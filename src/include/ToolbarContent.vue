<template>
  <v-toolbar
    flat
    dark
    :absolute="false"
    :fixed="false"
    class="primary lighten-1"
  >
    <v-toolbar-title v-text="title"></v-toolbar-title>
  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar-content',
  computed: {
    title() {
      return this.$route.meta.title || this.$route.name || 'Application'
    }
  }
}
</script>
