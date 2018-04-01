<template>
<div v-if="item.content">
  <v-layout
    :key="i"
    v-for="(e, i) in item.content"
    align-baseline
    :class="itemClass"
  >
    <div
      style="min-width: 32px"
      v-text="e.label + '.'"
    />
    <div v-html="$md.makeHtml(e.text)"/>
  </v-layout>
</div>
</template>

<script>
export default {
  name: 'curriculum-view',
  props: {
    item: Object,
    itemClass: {
      type: String,
      default: 'body-1 mb-1'
    }
  }
}
</script>
