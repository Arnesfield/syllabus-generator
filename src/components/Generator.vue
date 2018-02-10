<template>
<v-container fluid>
  <v-tabs-items v-model="$bus.tabs.Generator.tab">
    <v-tab-item key="course">
      <course-picker @course-selected="onCourseSelected"/>
    </v-tab-item>
    <v-tab-item key="syllabi" v-if="course">
      <syllabus-picker :course="course" @syllabus-selected="onSyllabusSelected"/>
    </v-tab-item>

    <template v-if="syllabus">
      
      <v-tab-item key="books">
        <book-picker :syllabus="syllabus"/>
      </v-tab-item>
      <v-tab-item key="curriculum">
        <curriculum-picker :syllabus="syllabus"/>
      </v-tab-item>

      <template v-if="syllabus.content.programOutcomes">
        <v-tab-item key="clo">
          <outcome-table
            :syllabus="syllabus"
            :supporting="syllabus.content.programOutcomes"
            abbr="clo"
            mainFieldName="courseLearningOutcomes"
            supportingFieldName="programOutcomes"
            mainTitle="Course Learning Outcomes (CLO)"
            supportingTitle="Program Outcomes (PO)"
            mapName="cloPoMap"/>
        </v-tab-item>
        <v-tab-item key="activities">
          <activity-manager :syllabus="syllabus"/>
        </v-tab-item>
        <v-tab-item key="done">
          <div>Syllabus is shown here.</div>
          <v-btn
            color="primary"
            @click="submit">Submit for Approval</v-btn>
        </v-tab-item>
      </template>

    </template>
  </v-tabs-items>
</v-container>
</template>

<script>
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
    // for navigation
    tabs: {
      course: ['course'],
      syllabi: ['course', 'syllabi'],
      noCurriculum: ['course', 'syllabi', 'books', 'curriculum'],
      all: ['course', 'syllabi', 'books', 'curriculum', 'clo', 'activities', 'done']
    }
  }),

  watch: {
    course(to, from) {
      this.$bus.tabs.Generator.items = to === null
        ? this.tabs.course : this.tabs.syllabi
    },

    syllabus: {
      deep: true,
      handler: function(to, from) {
        if (to === null) {
          this.$bus.tabs.Generator.items = this.course === null
            ? this.tabs.course : this.tabs.syllabi
        } else if (to.content.programOutcomes.length) {
          this.$bus.tabs.Generator.items = this.tabs.all
        } else {
          this.$bus.tabs.Generator.items = this.tabs.noCurriculum
        }
      }
    }
  },

  created() {
    this.$bus.tabs.Generator.tabs = true
    this.$bus.tabs.Generator.tab = null
    this.$bus.tabs.Generator.items = ['course']
    this.$bus.generator.suggestions = true
  },

  beforeDestroy() {
    this.$bus.tabs.Generator.tabs = null
    this.$bus.tabs.Generator.tab = null
    this.$bus.tabs.Generator.items = null
    this.$bus.generator.suggestions = true
  },

  methods: {
    submit() {
      // handle submit
      console.log(this.syllabus)
    },

    onCourseSelected(course) {
      this.course = course
    },
    onSyllabusSelected(syllabus) {
      if (syllabus !== null) {
        // show suggestions if syllabus is new
        this.$bus.generator.suggestions = typeof syllabus.id === 'undefined'
      }
      this.syllabus = syllabus
    }
  }
}
</script>
