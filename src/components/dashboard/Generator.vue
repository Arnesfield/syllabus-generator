<template>
<div>
  <h1>Generator</h1>
  <p>The core module. Information for syllabus is entered here.</p>
  <form @submit.prevent="submit">
    <!-- choose course -->
    <course-picker @course-selected="onCourseSelected"/>
    
    <template v-if="course">
      <hr>
      <syllabus-picker :course="course" @syllabus-selected="onSyllabusSelected"/>
      <template v-if="syllabus">
        <hr>
        <book-picker :syllabus="syllabus"/>
        <hr>
        <curriculum-picker :syllabus="syllabus"/>
      </template>
    </template>
    
    <!-- <outcome-mapper
      ref="outcomeMapper"
      :course="course"
      @syllabus-fetched="onSyllabusFetched"
      @ilo-add="iloAdd"
      @ilo-remove="iloRemove"/>

    <template v-if="syllabus">
      <hr>
      <activity-manager ref="activityManager" :syllabus="syllabus" @over="boxOver" @out="boxOut"/>
      <hr>
      <book-picker ref="bookPicker" :syllabus="syllabus"/>
      <hr>
      <used-materials-manager :syllabus="syllabus"/>
      <hr>
      <syllabus-info :syllabus="syllabus" :editor="editor"/>
    </template> -->

    <br>
    <div>
      <button type="submit">Generate</button>
    </div>
  </form>
</div>
</template>

<script>
import CoursePicker from '@/components/generator/CoursePicker'
import CurriculumPicker from '@/components/generator/CurriculumPicker'
import SyllabusPicker from '@/components/generator/SyllabusPicker'
import BookPicker from '@/components/generator/BookPicker'

import OutcomeMapper from '@/components/generator/OutcomeMapper'
import UsedMaterialsManager from '@/components/generator/UsedMaterialsManager'
import ActivityManager from '@/components/generator/ActivityManager'
import SyllabusInfo from '@/components/generator/SyllabusInfo'

export default {
  name: 'generator',
  components: {
    CoursePicker,
    CurriculumPicker,
    SyllabusPicker,
    BookPicker,

    OutcomeMapper,
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
      console.log(this.syllabus)
    },

    onCourseSelected(course) {
      this.course = course
    },
    onSyllabusSelected(syllabus) {
      this.syllabus = syllabus
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
    },
    iloAdd(index) {
      this.$refs.activityManager.iloAdd(index)
    },
    iloRemove(index) {
      this.$refs.activityManager.iloRemove(index)
    }
  }
}
</script>
