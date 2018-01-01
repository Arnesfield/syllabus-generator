<template>
<div>
  <h1>Generator</h1>
  <p>The core module. Information for syllabus is entered here.</p>
  <form @submit.prevent="submit">
    <!-- choose course -->
    <course-query @course-selected="onCourseSelected"/>
    
    <template v-if="course">
      <hr>
    </template>
    <outcome-mapper ref="outcomeMapper" :course="course" @syllabus-fetched="onSyllabusFetched"/>

    <template v-if="syllabus">
      <hr>
      <activity-manager :syllabus="syllabus" @over="boxOver" @out="boxOut"/>
      <hr>
      <book-picker ref="bookPicker" :syllabus="syllabus"/>
      <hr>
      <used-materials-manager :syllabus="syllabus"/>
      <hr>
      <syllabus-info :syllabus="syllabus" :editor="editor"/>
    </template>

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
import BookPicker from '@/components/generator/BookPicker'
import UsedMaterialsManager from '@/components/generator/UsedMaterialsManager'
import ActivityManager from '@/components/generator/ActivityManager'
import SyllabusInfo from '@/components/generator/SyllabusInfo'

export default {
  name: 'generator',
  components: {
    CourseQuery,
    OutcomeMapper,
    BookPicker,
    UsedMaterialsManager,
    ActivityManager,
    SyllabusInfo
  },
  data: () => ({
    course: null,
    syllabus: null,
    editor: null
  }),

  methods: {
    submit() {
      // handle submit
    },

    onCourseSelected(course) {
      this.course = course
    },
    onSyllabusFetched(syllabus, editor) {
      this.syllabus = syllabus
      this.editor = editor
    },

    // activity manager
    boxOver(label) {
      let iloTable = this.$refs.outcomeMapper.$refs.iloTable
      iloTable.$refs['content-' + label][0].style.backgroundColor = '#ccc'
    },
    boxOut(label) {
      let iloTable = this.$refs.outcomeMapper.$refs.iloTable
      iloTable.$refs['content-' + label][0].style.backgroundColor = null
    }
  }
}
</script>
