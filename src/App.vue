<template>
  <v-app id="app">
    <router-view/>
    <snackbar/>
    <fab :currRoute="$route.path"/>
  </v-app>
</template>

<script>
import Vue from 'vue'
import Snackbar from './include/Snackbar'
import Fab from '@/include/Fab'

export default {
  name: 'app',
  components: {
    Snackbar,
    Fab
  }
}
</script>
