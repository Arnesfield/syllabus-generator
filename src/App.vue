<template>
  <v-app id="app">
    <router-view/>
    <footer-view/>
  </v-app>
</template>

<script>
import FooterView from './include/FooterView'

export default {
  name: 'app',
  components: {
    FooterView
  }
}
</script>
