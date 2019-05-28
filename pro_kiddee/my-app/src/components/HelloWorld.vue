<template>
  <v-container>
    <v-layout row wrap>
      <v-flex offset-xl2 xl8>
        <v-carousel>
         <v-carousel-item
           v-for="(item,i) in items"
           :key="i"
           :src="item.src"
         ></v-carousel-item>
       </v-carousel>
        <Menu/>
      </v-flex>
    </v-layout>
  </v-container>
</template>
<script>
import Menu from '@/components/Menu.vue'
  export default {
    components: {
      Menu
    },
    data: () => ({
      items: [
         {
           src: 'https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg'
         },
         {
           src: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg'
         },
         {
           src: 'https://cdn.vuetifyjs.com/images/carousel/bird.jpg'
         },
         {
           src: 'https://cdn.vuetifyjs.com/images/carousel/planet.jpg'
         }
       ]
    })
  }
</script>
<style>
</style>
