<template>
<div v-if="syllabus">
  <markdown-textarea
    :md-view="false"
    v-model="text"
    t-add-class="my-big-textarea pa-2"
  />
</div>
</template>

<script>
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'grading-system',
  components: {
    MarkdownTextarea
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    text: null
  }),
  computed: {
    c() {
      return this.syllabus ? this.syllabus.content : null
    }
  },
  watch: {
    text(e) {
      if (this.c) {
        this.c.gradingSystem = e
      }
    }
  },
  created() {
    if (this.c) {
      this.text = this.c.gradingSystem
    }
  }
}
</script>
