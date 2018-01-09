<template>
<span>
  <span v-if="topic.label.length || topic.name.length">
    <template v-if="topic.label.length">{{ topic.label + '.' }}</template>
    <template v-if="topic.name.length">{{ topic.name }}</template>
  </span>
  <span v-if="topic.description.length">
    <ul v-if="topic.description.split('|').length > 1">
      <li v-for="(d, dIndex) in topic.description.split('|')"
        :key="dIndex">{{ d }}</li>
    </ul>
    <template v-else>{{ topic.description }}</template>
  </span>
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
