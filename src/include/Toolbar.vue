<template>
  <v-toolbar color="primary" dark app :tabs="$bus.tabs">
    <v-toolbar-side-icon @click.stop="$bus.drawer = !$bus.drawer"></v-toolbar-side-icon>
    <v-toolbar-title>{{ title }}</v-toolbar-title>
    <v-tabs
      align-with-title
      show-arrows
      color="primary"
      v-if="$bus.tabs"
      v-model="$bus.tab"
      slot="extension">
      <v-tabs-slider color="accent"/>
      <v-tab
        v-for="tab in $bus.tabItems"
        :key="tab">{{ tab }}</v-tab>
    </v-tabs>
  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar',
  props: {
    title: {
      type: String,
      default: 'Application'
    }
  }
}
</script>
