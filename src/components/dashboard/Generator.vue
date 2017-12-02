<template>
<div>
  <h1>Generator</h1>
  <p>The core module. Information for syllabus is entered here.</p>
  <form @submit.prevent="submit">
    <!-- choose course -->
    <course-query @course-selected="onCourseSelected"/>

    <br>
    <div>
      <button type="submit">Generate</button>
    </div>
  </form>
</div>
</template>

<script>
import qs from 'qs'
import CourseQuery from '@/components/generator/CourseQuery'

export default {
  name: 'generator',
  components: {
    CourseQuery
  },
  data: () => ({
    url: {
      syllabus: '/syllabus'
    },
    course: null
  }),

  methods: {
    submit() {
      // handle submit
    },

    onCourseSelected(course) {
      this.course = course
      // check for course latest syllabus
      this.$http.post(this.url.syllabus, qs.stringify({
        courseId: course._id
      })).then((res) => {
        console.log(res.data)
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
