<template>
<div>
  <h1>Generator</h1>
  <p>The core module. Information for syllabus is entered here.</p>
  <form @submit.prevent="submit">
    <!-- choose course -->
    <course-query/>
    <div>
      <button type="submit">Generate</button>
    </div>
  </form>
</div>
</template>

<script>
import CourseQuery from '@/components/generator/CourseQuery'

export default {
  name: 'generator',
  components: {
    CourseQuery
  },

  methods: {
    submit() {
      // handle submit
    }
  }
}
</script>
