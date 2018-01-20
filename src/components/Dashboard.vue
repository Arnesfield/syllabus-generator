<template>
<div>
  <navigation ref="nav" :bus="bus"/>
  <toolbar :bus="bus" :title="$route.meta.title"/>
  <v-content>
    <v-container fluid>
      <router-view :bus="bus"/>
    </v-container>
  </v-content>
</div>
</template>

<script>
import Navigation from '@/include/Navigation'
import Toolbar from '@/include/Toolbar'

export default {
  name: 'dashboard',
  components: {
    Navigation,
    Toolbar
  },
  props: {
    bus: Object
  },
  mounted() {
    this.$refs.nav.updateNav()
  },
}
</script>
