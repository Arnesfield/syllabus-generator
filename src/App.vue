<template>
  <v-app id="app">
    <router-view/>
    <snackbar/>
  </v-app>
</template>

<script>
import Vue from 'vue'
import Snackbar from './include/Snackbar'

export default {
  name: 'app',
  components: {
    Snackbar
  }
}
</script>
