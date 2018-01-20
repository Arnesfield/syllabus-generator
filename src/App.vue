<template>
  <v-app id="app">
    <router-view :bus="bus"/>
    <snackbar :bus="bus"/>
  </v-app>
</template>

<script>
import Vue from 'vue'
import Snackbar from './include/Snackbar'

export default {
  name: 'app',
  components: {
    Snackbar
  },
  data: () => ({
    bus: new Vue({
      data: () => ({
        // toolbar
        drawer: null
      })
    })
  })
}
</script>
