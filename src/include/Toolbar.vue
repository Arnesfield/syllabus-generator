<template>
  <v-toolbar
    app
    dark
    :clipped-left="$bus.nav.clipped"
    color="primary"
  >
    <v-toolbar-side-icon @click.stop="$bus.navToggle"/>
    <router-link to="/" class="white--text clean-a">
      <v-toolbar-title>Forge</v-toolbar-title>
    </router-link>
  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar'
}
</script>
