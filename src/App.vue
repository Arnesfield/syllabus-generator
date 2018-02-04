<template>
  <v-app id="app">
    <v-progress-linear
      height="3"
      color="accent"
      style="margin-top: 0; margin-bottom: 0; z-index: 1000"
      v-if="$bus.progress.active"
      :active="$bus.progress.active"
      :indeterminate="true"/>
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
