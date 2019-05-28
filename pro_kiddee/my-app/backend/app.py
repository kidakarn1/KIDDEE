from dbConfig import *
import sys
import os
import uuid

@app.route('/store/<path:filename>', methods=['GET', 'POST'])
def download(filename):
    return send_from_directory(directory='../src/user_image/', filename=filename)

@app.route('/api/uploadimage', methods=['POST'])
@connect_sql()
def upload_file(cursor):
    # check if the post request has the file part
    if 'file' not in request.files:
        # flash('No file part')
        print('No file part')
        return 'No file part'
    file = request.files['file']
    username = request.form['username']
    location_parameters = request.form['location_parameters']
    print(username)
    # if user does not select file, browser also
    # submit an empty part without filename
    if file.filename == '':
        # flash('No selected file')
        print('No selected file')
        return 'No selected file'
    if file and allowed_file(file.filename):
        path = " "
        if location_parameters=='Insert_user':
            path = "../src/user_image/"
        elif location_parameters=='Edit_user':
            path = "../src/user_image/"
        elif location_parameters=='Insert_cat':
            path = "../src/img_icon/"
        elif location_parameters=='Edit_cat':
            path = "../src/img_icon/"
        elif location_parameters=='Insert_sell':
            path = "../src/img_sell/"
        elif location_parameters=='Edit_sell':
            path = "../src/img_sell/"
        filename = secure_filename(file.filename)
        print(filename)
        fileExt = filename.split('.')[1]
        autoGenFileName = uuid.uuid4()
        newFileName = str(autoGenFileName) + '.' + fileExt

        if not os.path.isdir(path):
            os.mkdir(path)
        file.save(os.path.join(path, newFileName))
        created = datetime.utcnow()
        sql = ""
        if  location_parameters=='Insert_user':
            sql = """
            update user set user_image = %s where username = %s """
            cursor.execute(sql, (newFileName, username))
        elif location_parameters=='Edit_user':
            sql = """
            update user set user_image = %s where username = %s """
            cursor.execute(sql, (newFileName, username))
        elif location_parameters =='Insert_cat':
            sql = """
            update category set cat_icon = %s where cat_name = %s """
            cursor.execute(sql, (newFileName, username)) #username ก็ คือ cat_name ที่  Manage_cat สร้างไว้ function onUpload
        elif location_parameters =='Edit_cat':
            cat_id = request.form['cat_id']
            sql = """
            update category set cat_name = %s , cat_icon = %s where cat_id = %s """
            cursor.execute(sql, (username,newFileName,cat_id)) #username ก็ คือ cat_name ที่  Manage_cat สร้างไว้ function onUpload
            # print(username)
            # print(newFileName)
            # print(cat_id)
        elif location_parameters =='Insert_sell':
            sql_count_bill = "SELECT MAX(sell_id)  FROM sell"
            cursor.execute(sql_count_bill)
            pk = cursor.fetchone()
            sql = """
            update sell set sell_image = %s where sell_id = %s """
            cursor.execute(sql, (newFileName,pk))
        elif location_parameters =='Edit_sell':
            sell_id = request.form['sell_id']
            sql = """
            update sell set sell_image = %s where sell_id = %s """
            cursor.execute(sql, (newFileName,sell_id))
        print("Success")
        return "Success"

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
@app.route('/show_user_buys_status', methods=['POST'])
@connect_sql()
def show_user_buys_status(cursor):
    try:
        data = request.json
        sql_count_bill = "SELECT MAX(bill_id)  FROM buys where username = %s"
        cursor.execute(sql_count_bill,(data['user']))
        re = cursor.fetchone()
        sql="select * from buys,sell,user where buys.bill_id = %s and buys.buys_status = %s and buys.sell_id = sell.sell_id and sell.username = user.username"
        cursor.execute(sql,(re[0],'B'))
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/Alert_sell_user', methods=['POST'])
@connect_sql()
def Alert_sell_user(cursor):
    try:
        data = request.json
        sql="""select * from buys,sell,user where (buys.buys_status = %s and
         buys.sell_id = sell.sell_id and
         buys.username = user.username) and sell.username = %s"""
        cursor.execute(sql,('B',data['username']))
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/show_user_buys/<username>', methods=['GET'])
@connect_sql()
def show_user_buys(cursor,username):
    try:
        sql="select * from buys,sell where buys.username = %s and buys.buys_status = %s and buys.sell_id = sell.sell_id"
        cursor.execute(sql,(username,'R'))
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/cart', methods=['POST'])
@connect_sql()
def cart(cursor):
    try:
        data = request.json
        # sql_count = "SELECT COUNT(bill_id)  FROM `buys` WHERE `buys_status` = 'B'"
        # cursor.execute(sql_count)
        # result_count = cursor.fetchone()

        sql_get_number="select * from sell where sell_id = %s"
        cursor.execute(sql_get_number,data['sell_id'])
        re = cursor.fetchone()
        total_number = int(re[9])  - int(data['number_buy'])
        sql_update_sell_number="""update sell set  sell_number = %s where sell_id = %s"""
        cursor.execute(sql_update_sell_number,(total_number,data['sell_id']))
        check_user_up_in = """ select count(buys_id)  from buys where sell_id = %s and username = %s and buys_status = %s """
        cursor.execute(check_user_up_in,(data['sell_id'],data['username'],'R'))
        res = cursor.fetchone()
        if res[0]==0:
            sql_in_buy="""insert into buys (sell_id , username , number_buy) VALUES (%s,%s,%s)"""
            cursor.execute(sql_in_buy,(data['sell_id'],data['username'],data['number_buy']))
            return jsonify('insert'),200
        else:
            nb = int(res[0]) + int(data['number_buy'])
            sql_up_buy="""update buys set number_buy = %s where sell_id = %s and username = %s and buys_status = %s """
            cursor.execute(sql_up_buy,(nb,data['sell_id'],data['username'],'R'))
            return jsonify('update'),200
        print(type(data))
        return jsonify(res[0]),200
    except Exception as e:
        return jsonify(str(e)),400

@app.route('/count_buy/<username>', methods=['GET'])
@connect_sql()
def count_buy(cursor,username):
    try:
        sql="select count(buys_id) as count_buy_id from buys where username = %s and buys_status = %s"
        cursor.execute(sql,(username,'R'))
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/get_data_sell_of_groups/<id>', methods=['GET'])
@connect_sql()
def get_data_sell_of_groups(cursor,id):
    try:
        sql="select * from sell,user where (sell.sell_number > 0) and groups_id = %s and user.username = sell.username"
        cursor.execute(sql,id)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/get_name_groups/<id>', methods=['GET'])
@connect_sql()
def get_name_groups(cursor,id):
    try:
        sql="select * from groups where cat_id = %s "
        cursor.execute(sql,id)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/getdata_sell/<id>', methods=['GET'])
@connect_sql()
def getdata_sell(cursor,id):
    try:
        sql="select * from category,groups,sell,user where (sell_number >=1 )and category.cat_id = %s and groups.cat_id = category.cat_id and sell.groups_id =groups.groups_id and user.username = sell.username "
        cursor.execute(sql,id)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/get_image_database', methods=['GET'])
@connect_sql()
def getdata_image(cursor):
    try:
        sql="select * from image"
        cursor.execute(sql)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/get_category', methods=['GET'])
@connect_sql()
def get_category(cursor):
    try:
        sql="select * from category"
        cursor.execute(sql)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/Buys', methods=['POST'])
@connect_sql()
def update_Buys(cursor):
    try:
        data = request.json
        sql_count_bill = "SELECT MAX(bill_id)  FROM buys"
        cursor.execute(sql_count_bill)
        re = cursor.fetchone()
        bill_id= int(re[0])+1
        sql="""update buys set  bill_id = %s , buys_status = %s , buys_address = %s where username = %s and buys_status = %s """
        cursor.execute(sql,(bill_id,'B',data['address'],data['username'],'R'))
        return jsonify("success"),200
    except Exception as e:
        return jsonify(str(e)),400

@app.route('/update_data', methods=['POST'])
@connect_sql()
def update_data(cursor):
    try:
        data = request.json
        sql="""update user set  username = %s , password = %s , fname = %s, lname=%s,status=%s, phone=%s , user_image=%s , user_address = %s where user_id = %s"""
        cursor.execute(sql,(data['username'],data['password'],data['fname'],data['lname'],data['status'],data['phone'],data['image'],data['user_address'],data['user_id']))
        print(type(data))
        return jsonify("แก้ไขสำเร็จ")
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/update_data_buys', methods=['POST'])
@connect_sql()
def update_data_buys(cursor):
    try:
        data = request.json
        sql="""update buys set number_buy = %s , buys_status = %s where buys_id = %s"""
        cursor.execute(sql,(data['number_buy'],data['buys_status'],data['buys_id']))
        print(type(data))
        return jsonify("แก้ไขสำเร็จ")
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/update_data_sell', methods=['POST'])
@connect_sql()
def update_data_sell(cursor):
    try:
        data = request.json
        sql="""update sell set  username = %s , groups_id = %s , sell_name = %s, sell_image=%s,sell_address=%s, sell_price=%s , date_start = %s , description=%s , sell_number=%s  where sell_id = %s"""
        cursor.execute(sql,(data['username'],data['groups_id'],data['sell_name'],data['sell_image'],data['sell_address'],data['sell_price'],data['date'],data['description'],data['sell_number'],data['sell_id']))
        print(type(data))
        return jsonify("แก้ไขสำเร็จ")
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/update_data_cat', methods=['POST'])
@connect_sql()
def update_data_cat(cursor):
    try:
        data = request.json
        sql="""update  category set  cat_name = %s , cat_icon = %s where cat_id = %s"""
        cursor.execute(sql,(data['cat_name'],data['cat_icon'],data['cat_id']))
        print(type(data))
        return jsonify("แก้ไขสำเร็จ"),200
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/update_data_groups', methods=['POST'])
@connect_sql()
def update_data_groups(cursor):
    try:
        data = request.json
        sql="""update  groups set  groups_name = %s , cat_id = %s where groups_id = %s"""
        cursor.execute(sql,(data['groups_name'],data['cat_id'],data['groups_id']))
        print(type(data))
        return jsonify("แก้ไขสำเร็จ")
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/add_data', methods=['POST'])
@connect_sql()
def insert_data(cursor):
    try:
        data = request.json
        sql = "SELECT COUNT(username)  FROM `user` WHERE `username` LIKE %s"
        cursor.execute(sql, data['username'])
        re = cursor.fetchone()
        status=0
        if re[0]==0:
            sql="""INSERT INTO user (username, password, fname, lname, status, phone, user_image,user_address) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
            cursor.execute(sql,(data['username'],data['password'],data['fname'],data['lname'],data['status'],data['phone'],data['image'],data['user_address']))
            status=200
            return jsonify(status)
        else:
            status=150
            return jsonify(status)
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/add_data_sell', methods=['POST'])
@connect_sql()
def add_data_sell(cursor):
    try:
        data = request.json
        sql="""INSERT INTO sell (username, groups_id, sell_name, sell_image, sell_address, sell_price, description, sell_number)  VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
        cursor.execute(sql,(data['username'],data['groups_id'],data['sell_name'],data['sell_image'],data['sell_address'],data['sell_price'],data['description'],data['sell_number']))
        status=200
        return jsonify(status)
    except Exception as e:
        return jsonify(str(e)),400

@app.route('/add_data_cat', methods=['POST'])
@connect_sql()
def insert_cat(cursor):
    try:
        data = request.json
        sql = "SELECT COUNT(cat_name)  FROM category  WHERE cat_name = %s"
        cursor.execute(sql, data['cat_name'])
        re = cursor.fetchone()
        status=0
        if re[0]==0:
            sql="""INSERT INTO category (cat_name, cat_icon ) VALUES (%s,%s)"""
            cursor.execute(sql,(data['cat_name'],data['cat_icon']))
            status=200
            return jsonify(status)
        else:
            status=150
            return jsonify(status)
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/add_data_groups', methods=['POST'])
@connect_sql()
def insert_groups(cursor):
    try:
        data = request.json
        sql = "SELECT COUNT(groups_name)  FROM groups  WHERE groups_name = %s"
        cursor.execute(sql,data['groups_name'])
        re = cursor.fetchone()
        status=0
        if re[0]==0:
            sql="""INSERT INTO  groups (groups_name,cat_id) VALUES (%s,%s)"""
            cursor.execute(sql,(data['groups_name'],data['cat_id']))
            status=200
            return jsonify(status)
        else:
            status=150
            return jsonify(status)
    except Exception as e:
        return jsonify("ERROR"),400

@app.route('/test', methods=['GET'])
@connect_sql()
def test_sql(cursor):
    sql = """SELECT * FROM user"""
    cursor.execute(sql)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify(result)

@app.route('/show_data_cat', methods=['GET'])
@connect_sql()
def show_data_cat(cursor):
    sql = """SELECT * FROM category"""
    cursor.execute(sql)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify(result)

@app.route('/show_data_buys', methods=['GET'])
@connect_sql()
def show_data_buys(cursor):
    sql = """SELECT * FROM buys,sell,user,groups,category where buys.sell_id = sell.sell_id and buys.username = user.username and sell.groups_id = groups.groups_id and groups.cat_id = category.cat_id"""
    cursor.execute(sql)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify(result)

@app.route('/show_data_buys_from_status/<id>', methods=['GET'])
@connect_sql()
def show_data_buys_from_status(cursor,id):
    sql = """SELECT * FROM buys,sell,user where (buys.sell_id = sell.sell_id and buys.username = user.username) and buys.buys_status Like %s """
    cursor.execute(sql,id)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify(result)

@app.route('/show_data_sell', methods=['POST'])
@connect_sql()
def show_data_sell(cursor):
    data = request.json
    if data['status']=='A':
        sql = """SELECT * FROM sell,user,groups where sell.username = user.username and sell.groups_id = groups.groups_id"""
        cursor.execute(sql)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result)
    else:
        sql = """SELECT * FROM sell,user,groups where user.username = %s and sell.username = user.username and sell.groups_id = groups.groups_id"""
        cursor.execute(sql,data['username'])
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result)

@app.route('/show_data_groups', methods=['GET'])
@connect_sql()
def show_data_groups(cursor):
    sql = """SELECT * FROM groups,category where groups.cat_id = category.cat_id"""
    cursor.execute(sql)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify(result)

@app.route('/login/<user>/<passwd>', methods=['GET'])
@connect_sql()
def check_login(cursor,user,passwd):
    try:
        sql = """SELECT * FROM user where username = %s and password = %s """
        cursor.execute(sql,(user,passwd))
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify(result),200
    except Exception as e:
        return (str(e)),400

@app.route('/test/<id>', methods=['GET'])
@connect_sql()
def t_s(cursor,id):
    sql = """SELECT * FROM user where user_id = '%s'"""
    cursor.execute(sql,id)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify(result)

@app.route('/delete_user/<id>', methods=['GET'])
@connect_sql()
def delete_sql(cursor,id):
    try:
        sql = """delete from user where user_id = %s """
        cursor.execute(sql,id)
        return jsonify('ลบสำเร็จ')
    except Exception as e:
        return jsonify(str(e))

@app.route('/delete_buys/<id>/<number>/<sell_id>', methods=['GET'])
@connect_sql()
def delete_buys(cursor,id,number,sell_id):
    try:
        sql_select = "select sell_number from  sell where sell_id = %s"
        cursor.execute(sql_select,sell_id)
        result_select = cursor.fetchone()
        number_sell = result_select[0]+int(number)
        sql = """delete from buys where buys_id = %s """
        cursor.execute(sql,id)
        sql_return_number = "update sell set sell_number = %s where sell_id = %s"
        cursor.execute(sql_return_number,(number_sell,sell_id))
        return jsonify("ลบสำเร็จ")
    except Exception as e:
        return jsonify(str(e))

@app.route('/delete_groups/<id>', methods=['GET'])
@connect_sql()
def delete_groups_sql(cursor,id):
    try:
        sql = """delete from groups where groups_id = %s """
        cursor.execute(sql,id)
        return jsonify('ลบสำเร็จ')
    except Exception as e:
        return jsonify(str(e))

@app.route('/delete_sell/<id>', methods=['GET'])
@connect_sql()
def delete_sell_sql(cursor,id):
    try:
        sql = """delete from sell where sell_id = %s """
        cursor.execute(sql,id)
        return jsonify('ลบสำเร็จ')
    except Exception as e:
        return jsonify(str(e))

@app.route('/delete_cat/<id>', methods=['GET'])
@connect_sql()
def delete_category(cursor,id):
    try:
        sql = """delete from category where cat_id = %s """
        cursor.execute(sql,id)
        return jsonify('ลบสำเร็จ')
    except Exception as e:
        return jsonify(str(e))

@app.route('/getproductimage/<product_id>', methods=['GET'])
@connect_sql()
def getproductimagebyid(cursor, product_id):
    data = request.json
    sql = "SELECT * FROM `products` WHERE `product_id` = %s"
    cursor.execute(sql,product_id)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    return jsonify({"product": result})

@app.route('/getproduct/<product_id>', methods=['GET'])
@connect_sql()
def getproductbyid(cursor,product_id):
    sql = "SELECT * FROM `products` WHERE `product_id` = %s"
    cursor.execute(sql,product_id)
    columns = [column[0] for column in cursor.description]
    result = toJson(cursor.fetchall(), columns)
    # print(result)
    for i in result:
        categoryList = []
        sql1 = "SELECT * FROM `category` WHERE category_id=%s"
        cursor.execute(sql1, (i["category_id"]))
        columns = [column[0] for column in cursor.description]
        resulProduct = toJson(cursor.fetchall(), columns)
        for i1 in resulProduct:
            categoryList.append(i1)
            i["category"] = categoryList
            i.pop('category_id', None)

    for i in result:
        image_productsList = []
        sql1 = "SELECT image_url FROM `image_products` WHERE `product_id` = %s"
        cursor.execute(sql1, (i["product_id"]))
        columns = [column[0] for column in cursor.description]
        resulProduct = toJson(cursor.fetchall(), columns)
        for i1 in resulProduct:
            image_productsList.append(i1)
            i["image_products"] = image_productsList

    return jsonify({"product": result})

@app.route('/category', methods=['GET', 'POST', 'DELETE', 'PATCH'])
@connect_sql()
def category(cursor):
    if request.method == 'GET':
        sql = "SELECT * FROM category"
        cursor.execute(sql)
        columns = [column[0] for column in cursor.description]
        result = toJson(cursor.fetchall(), columns)
        return jsonify({'category': result})


@app.route('/register', methods=['POST'])
@connect_sql()
def register(cursor):

    try:
        data = request.json
        ret = {}
        sql = "SELECT COUNT(email)  FROM `user` WHERE `email` LIKE %s"
        cursor.execute(sql, data['email'])
        regis_email = cursor.fetchone()
        status = 0
        msg = ''
        if(regis_email[0] == 0):
            created = datetime.utcnow()
            position = 'member'
            sql = """INSERT INTO `user` (`fname`, `lname`, `email`, `password`, `created_date`, `position`) VALUES (%s, %s, %s, %s, %s,%s)"""
            cursor.execute(
                sql, (data['fname'], data['lname'], data['email'], data['password'], created, position))
            ret = {"msg": {"title": 'สมัครสามาชิกสำเร็จ',"status": 'success', 'show': True}}
            status = 200
        else:
            ret = {"msg": {"title": 'email นี้มีผู้ใช้งานแล้ว',
                            "status": 'error', 'show': True}}
            status = 401
        return jsonify(ret), status
    except:
        return jsonify({'register': 'fail'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', threaded=True, port=5000)
