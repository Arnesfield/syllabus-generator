<template>
  <v-app id="app">
    <navigation ref="nav" :bus="bus"/>
    <toolbar
      :bus="bus"
      :title="$route.meta.title"/>
    <v-content>
      <v-container fluid>
        <router-view @update-nav="$refs.nav.updateNav()"/>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
import Vue from 'vue'
import Navigation from '@/include/Navigation'
import Toolbar from '@/include/Toolbar'

export default {
  name: 'app',
  components: {
    Navigation,
    Toolbar
  },
  data: () => ({
    bus: new Vue({
      data: () => ({
        drawer: null
      })
    })
  }),
  mounted() {
    this.$refs.nav.updateNav()
  }
}
</script>
