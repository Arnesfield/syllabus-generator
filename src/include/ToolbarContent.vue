<template>
  <v-toolbar
    flat
    dark
    :tabs="typeof $bus.tabs[$route.name] !== 'undefined'"
    :absolute="false"
    :fixed="false"
    class="primary lighten-1"
  >
    <v-btn icon dark>
      <v-icon>{{ $route.meta.icon }}</v-icon>
    </v-btn>
    <v-toolbar-title v-text="title"></v-toolbar-title>

    <v-tabs
      align-with-title
      show-arrows
      color="primary lighten-1"
      v-if="typeof $bus.tabs[$route.name] !== 'undefined'"
      v-model="$bus.tabs[$route.name].tab"
      slot="extension">
      <v-tabs-slider color="accent"/>
      <v-tab
        v-for="tab in $bus.tabs[$route.name].items"
        :key="tab">{{ tab }}</v-tab>
    </v-tabs>

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
