<template>
<div>
  <v-tooltip
    top
    :key="i"
    v-for="(course, i) in courses"
  >
    <v-chip
      label
      slot="activator"
      @click="$emit('select', course.id, course.code)"
    >
      <div class="clickable">{{ course.code }}</div>
    </v-chip>
    <span v-text="course.title"/>
  </v-tooltip>
</div>
</template>

<script>
export default {
  name: 'related-course-chips',
  props: {
    courses: Array
  }
}
</script>
