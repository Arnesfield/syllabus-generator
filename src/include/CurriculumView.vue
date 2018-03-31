<template>
<div>
  <v-layout
    :key="i"
    v-for="(e, i) in item.content"
    align-baseline
    class="body-1 mb-1"
  >
    <div
      style="min-width: 32px"
      v-text="e.label"
    />
    <div v-html="$md.makeHtml(e.text)"/>
  </v-layout>
</div>
</template>

<script>
export default {
  name: 'curriculum-view',
  props: {
    item: Object
  }
}
</script>
