<template>
<div>
  <navigation ref="nav" :bus="bus"/>
  <toolbar :bus="bus" :title="$route.meta.title"/>
  <v-content>
    <v-container fluid>
      <router-view/>
    </v-container>
  </v-content>
</div>
</template>

<script>
import Vue from 'vue'
import Navigation from '@/include/Navigation'
import Toolbar from '@/include/Toolbar'

export default {
  name: 'dashboard',
  components: {
    Navigation,
    Toolbar
  },
  data: () => ({
    bus: new Vue({
      data: () => ({
        drawer: false
      })
    })
  }),
  mounted() {
    this.$refs.nav.updateNav()
  },
}
</script>
