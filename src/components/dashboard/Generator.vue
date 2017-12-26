<template>
<div>
  <h1>Generator</h1>
  <p>The core module. Information for syllabus is entered here.</p>
  <form @submit.prevent="submit">
    <!-- choose course -->
    <course-query @course-selected="onCourseSelected"/>
    <outcome-mapper ref="outcomeMapper" @syllabus-fetched="onSyllabusFetched"/>
    <topic-picker ref="topicPicker"/>

    <br>
    <div>
      <button type="submit">Generate</button>
    </div>
  </form>
</div>
</template>

<script>
import CourseQuery from '@/components/generator/CourseQuery'
import OutcomeMapper from '@/components/generator/OutcomeMapper'
import TopicPicker from '@/components/generator/TopicPicker'

export default {
  name: 'generator',
  components: {
    CourseQuery,
    OutcomeMapper,
    TopicPicker
  },
  data: () => ({
    course: null,
    syllabus: null
  }),

  methods: {
    submit() {
      // handle submit
    },

    onCourseSelected(course) {
      this.course = course
      this.$refs.outcomeMapper.onCourseSelected(course)
    },
    onSyllabusFetched(syllabus) {
      this.syllabus = syllabus
      this.$refs.topicPicker.onSyllabusFetched(syllabus)
    }
  }
}
</script>
