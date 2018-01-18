<template>
<div>
  <div>
    <!-- choose course -->
    <course-picker @course-selected="onCourseSelected"/>
    <syllabus-picker :course="course" @syllabus-selected="onSyllabusSelected"/>
    <book-picker :syllabus="syllabus"/>
    
    <template v-if="course">
      <template v-if="syllabus">
        <hr>
        <curriculum-picker :syllabus="syllabus"/>
        <template v-if="syllabus.content.programOutcomes.length">
          <hr>
          <outcome-table
            :syllabus="syllabus"
            :supporting="syllabus.content.programOutcomes"
            abbr="clo"
            mainFieldName="courseLearningOutcomes"
            supportingFieldName="programOutcomes"
            mainTitle="Course Learning Outcomes (CLO)"
            supportingTitle="Program Outcomes (PO)"
            mapName="cloPoMap"
            connectedMapName="iloCloMap"/>
          <hr>
          <outcome-table
            :syllabus="syllabus"
            :supporting="syllabus.content.courseLearningOutcomes"
            abbr="ilo"
            mainFieldName="intendedLearningOutcomes"
            supportingFieldName="courseLearningOutcomes"
            mainTitle="Intended Learning Outcomes (ILO)"
            supportingTitle="Course Learning Outcomes (CLO)"
            mapName="iloCloMap"
            :bus="bus"/>
          <hr>
          <activity-manager
            :syllabus="syllabus"
            :bus="bus"/>
        </template>
      </template>
    </template>

    <br>
    <div>
      <button @click="submit">Generate</button>
    </div>
  </div>
</div>
</template>

<script>
import Vue from 'vue'
import CoursePicker from '@/components/generator/CoursePicker'
import CurriculumPicker from '@/components/generator/CurriculumPicker'
import SyllabusPicker from '@/components/generator/SyllabusPicker'
import BookPicker from '@/components/generator/BookPicker'
import OutcomeTable from '@/components/generator/OutcomeTable'
import ActivityManager from '@/components/generator/ActivityManager'

export default {
  name: 'generator',
  components: {
    CoursePicker,
    CurriculumPicker,
    SyllabusPicker,
    BookPicker,
    OutcomeTable,
    ActivityManager
  },
  data: () => ({
    course: null,
    syllabus: null,
    bus: new Vue()
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
    }
  }
}
</script>
