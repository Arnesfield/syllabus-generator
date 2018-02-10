<template>
<span>
  <span v-if="topic.label.length || topic.name.length">
    <template v-if="topic.label.length">{{ topic.label + '.' }}</template>
    <template v-if="topic.name.length">{{ topic.name }}</template>
  </span>
  <span
    v-if="topic.description.length"
    v-html="topic.description"></span>
</span>
</template>

<script>
export default {
  name: 'topic',
  props: {
    topic: Object
  }
}
</script>
