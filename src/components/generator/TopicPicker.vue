<template>
<div v-if="syllabus">

</div>
</template>

<script>
export default {
  name: 'topic-picker',
  data: () => ({
    syllabus: null
  }),

  methods: {
    onSyllabusFetched(syllabus) {
      this.syllabus = syllabus
    }
  }
}
</script>
