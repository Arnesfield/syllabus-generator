<template>
<div>
  <h1>Generator</h1>
  <p>The core module. Information for syllabus is entered here.</p>
  <form @submit.prevent="submit">
    <!-- choose course -->
    <course-query @course-selected="onCourseSelected"/>
    <outcome-mapper ref="outcomeMapper" :course="course" @syllabus-fetched="onSyllabusFetched"/>
    <topic-picker ref="topicPicker" :syllabus="syllabus"/>
    <used-materials-manager :syllabus="syllabus"/>

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
import UsedMaterialsManager from '@/components/generator/UsedMaterialsManager'

export default {
  name: 'generator',
  components: {
    CourseQuery,
    OutcomeMapper,
    TopicPicker,
    UsedMaterialsManager
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
    },
    onSyllabusFetched(syllabus) {
      this.syllabus = syllabus
    }
  }
}
</script>
