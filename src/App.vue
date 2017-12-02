<template>
  <div id="app">
    <navigation ref="nav"/>
    <router-view @update-nav="$refs.nav.updateNav()"/>
  </div>
</template>

<script>
import Navigation from '@/include/Navigation'

export default {
  name: 'app',
  components: {
    Navigation
  }
}
</script>
