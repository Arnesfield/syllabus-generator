<template>
  <v-toolbar color="primary" dark app>
    <v-toolbar-side-icon @click.stop="bus.drawer = !bus.drawer"></v-toolbar-side-icon>
    <v-toolbar-title>{{ title }}</v-toolbar-title>
  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar',
  props: {
    title: {
      type: String,
      default: 'Application'
    },
    bus: {
      type: Object,
      required: true
    }
  }
}
</script>
