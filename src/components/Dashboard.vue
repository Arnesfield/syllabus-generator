<template>
<div>
  <navigation ref="nav"/>
  <toolbar :title="$route.meta.title"/>
  <v-content>
    <v-container fluid>
      <router-view/>
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
  mounted() {
    this.$refs.nav.updateNav()
  },
}
</script>
