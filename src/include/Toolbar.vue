<template>
  <v-toolbar
    app
    dark
    :clipped-left="$bus.nav.clipped"
    color="primary"
  >
    <v-toolbar-side-icon @click.stop="$bus.nav.model = !$bus.nav.model"></v-toolbar-side-icon>
    <v-toolbar-title>JSpot</v-toolbar-title>
    <v-spacer></v-spacer>
  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar'
}
</script>
