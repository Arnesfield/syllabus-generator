<template>
<v-container
  fluid
  :style="!syllabus ? {
    display: 'flex',
    width: '100%',
    height: 'calc(100% - 160px)'
  } : null"
>
  <v-tabs-items
    v-model="$bus.tabs.Generator.tab"
    class="full-width"
  >
    <v-tab-item key="course">
      <course-picker
        ref="coursePicker"
        :picker="!assignId"
        @course-selected="onCourseSelected"
      />
    </v-tab-item>
    <v-tab-item key="syllabi" v-if="course">
      <syllabus-picker
        ref="syllabusPicker"
        :course="course"
        @syllabus-selected="onSyllabusSelected"
      />
    </v-tab-item>

    <template v-if="syllabus">
      
      <v-tab-item key="books">
        <book-picker :syllabus="syllabus"/>
      </v-tab-item>
      <v-tab-item key="curriculum">
        <curriculum-picker :syllabus="syllabus"/>
      </v-tab-item>

      <template v-if="syllabus.content && syllabus.content.programOutcomes">
        <v-tab-item key="clo">
          <outcome-table
            :syllabus="syllabus"
            :supporting="syllabus.content.programOutcomes"
            mainTitle="Course Learning Outcomes (CLO)"
            supportingTitle="Program Outcomes (PO)"
          />
        </v-tab-item>
        <v-tab-item key="activities">
          <activity-manager :syllabus="syllabus"/>
        </v-tab-item>
        <v-tab-item key="grading">
          <grading-system :syllabus="syllabus"/>
        </v-tab-item>
        <v-tab-item key="done">
          <div>
            <syllabus-inst
              ref="syllabusInst"
              :syllabus="syllabus"
              style="margin: 0 auto"
              :pdf.sync="pdf"
            />
          </div>
          <v-layout class="mt-2">
            <v-btn
              flat
              @click="generate(false)"
            >Preview</v-btn>
            <v-btn
              flat
              @click="generate(true)"
            >PDF</v-btn>
            <v-spacer/>
            <v-btn
              color="primary"
              @click="submit"
            >Submit for Approval</v-btn>
          </v-layout>
        </v-tab-item>
      </template>

    </template>
  </v-tabs-items>

  <v-layout
    justify-center
    align-center
    v-if="assignId && !course"
  >
    <manage-no-data
      :fetch="fetchCourse"
      :loading="courseLoading"
    />
  </v-layout>

</v-container>
</template>

<script>
import qs from 'qs'
import content from '@/assets/js/content'
import CoursePicker from '@/components/generator/CoursePicker'
import CurriculumPicker from '@/components/generator/CurriculumPicker'
import SyllabusPicker from '@/components/generator/SyllabusPicker'
import BookPicker from '@/components/generator/BookPicker'
import OutcomeTable from '@/components/generator/OutcomeTable'
import ActivityManager from '@/components/generator/ActivityManager'
import GradingSystem from '@/components/generator/GradingSystem'
import ManageNoData from '@/include/ManageNoData'
import SyllabusInst from '@/include/SyllabusInst'

export default {
  name: 'generator',
  components: {
    CoursePicker,
    CurriculumPicker,
    SyllabusPicker,
    BookPicker,
    OutcomeTable,
    ActivityManager,
    GradingSystem,
    ManageNoData,
    SyllabusInst
  },
  props: {
    assignId: String
  },
  data: () => ({
    submitUrl: '/syllabi/submit',
    saveUrl: '/syllabi/save',
    courseUrl: '/courses/assign_id',
    course: null,
    syllabus: null,
    // for navigation
    tabs: {
      course: ['course'],
      syllabi: ['course', 'syllabi'],
      noCurriculum: ['course', 'syllabi', 'books', 'curriculum'],
      all: ['course', 'syllabi', 'books', 'curriculum', 'clo', 'activities', 'grading', 'done']
    },
    pdf: false,

    tempSyllabus: null,

    saveLoading: false,
    courseLoading: false
  }),

  watch: {
    courseLoading(to, from) {
      this.$bus.progress.circular.Generator.course = to
    },
    saveLoading(to, from) {
      this.$bus.progress.circular.Generator.save = to
    },

    course(to, from) {
      // set course picker course here
      if (this.$refs.coursePicker) {
        this.$refs.coursePicker.selected = to
      }
      this.$bus.tabs.Generator.items = to === null
        ? this.tabs.course : this.tabs.syllabi
    },

    assignId(to, from) {
      if (to) {
        // this.$bus.$on('generator--course.refresh', this.fetchCourse)
        this.fetchCourse()
      } else {
        // remove course
        this.course = null
      }
    },

    syllabus: {
      deep: true,
      handler: function(to, from) {
        if (to === null) {
          this.$bus.tabs.Generator.items = this.course === null
            ? this.tabs.course : this.tabs.syllabi
        } else if (
          to.content &&
          to.content.programOutcomes &&
          to.content.programOutcomes.length
        ) {
          this.$bus.tabs.Generator.items = this.tabs.all
          this.stringifySyllabus()
        } else {
          this.$bus.tabs.Generator.items = this.tabs.noCurriculum
        }
      }
    }
  },

  created() {
    this.$bus.$on('generator--save', this.save)
    this.$bus.$on('syllabus-picker--syllabus.set', this.syllabusSet)

    this.$bus.tabs.Generator.tabs = true
    this.$bus.tabs.Generator.tab = null
    this.$bus.tabs.Generator.items = ['course']
    this.$bus.generator.suggestions = true

    if (this.assignId !== null) {
      this.$bus.$on('generator--course.refresh', this.fetchCourse)
      // do async and set the course
      // also set refresh button if failed
      this.fetchCourse()
    }

    this.$bus.nav.model = null
    this.$bus.nav.miniVariant = true
  },

  beforeDestroy() {
    this.$bus.tabs.Generator.tabs = null
    this.$bus.tabs.Generator.tab = null
    this.$bus.tabs.Generator.items = null
    this.$bus.generator.suggestions = true

    this.$bus.$off('generator--save', this.save)
    this.$bus.$off('syllabus-picker--syllabus.set', this.syllabusSet)
    this.$bus.$off('generator--course.refresh', this.fetchCourse)
  },

  methods: {
    syllabusSet() {
      // set syllabus in picker
      if (this.$refs.syllabusPicker) {
        this.$refs.syllabusPicker.selected = this.tempSyllabus
      }
    },

    generate(e) {
      this.pdf = e
      this.stringifySyllabus()
      if (this.$refs.syllabusInst) {
        this.$refs.syllabusInst.generate(e)
      }
    },

    stringifySyllabus() {
      // if syllabus not yet set
      if (this.syllabus === null) {
        return JSON.stringify(null)
      }
      // should not be fixed
      // loop on content keys instead
      Object.keys(content).forEach(e => {
        this.$set(this.syllabus.content, e, content[e])
      })
      // Object.assign(this.syllabus.content, content)
      // Object.assign(this.syllabus.content, { course: this.course })
      this.$set(this.syllabus.content, 'course', this.course)
      return JSON.stringify(this.syllabus ? this.syllabus.content : null)
    },

    submit() {
      // handle submit
      console.log(this.syllabus)

      if (!this.assignId) {
        return
      }

      let syllabus = this.stringifySyllabus()
      this.saveLoading = true
      this.$http.post(this.submitUrl, qs.stringify({
        assignId: this.assignId,
        syllabus: syllabus
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.saveLoading = false
        this.$bus.$emit('snackbar--show', 'Syllabus submitted.')
      }).catch(e => {
        console.error(e)
        this.saveLoading = false
        this.$bus.$emit('snackbar--show', {
          text: 'Unable to submit syllabus.',
          btns: {
            text: 'Retry',
            icon: false,
            color: 'accent',
            cb: (sb, e) => {
              this.submit()
              sb.snackbar = false
            }
          }
        })
      })
    },

    onCourseSelected(course) {
      this.course = course
    },
    onSyllabusSelected(syllabus) {
      if (syllabus !== null) {
        // show suggestions if syllabus is new
        // actually always show suggestions boi
        this.$bus.generator.suggestions = true // typeof syllabus.id === 'undefined'
      }
      this.syllabus = syllabus
    },

    save() {
      if (!this.assignId) {
        return
      }

      let syllabus = this.stringifySyllabus()
      this.saveLoading = true
      this.$http.post(this.saveUrl, qs.stringify({
        assignId: this.assignId,
        syllabus: syllabus
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.saveLoading = false
        this.$bus.$emit('snackbar--show', 'Syllabus saved.')
      }).catch(e => {
        console.error(e)
        this.saveLoading = false
        this.$bus.$emit('snackbar--show', {
          text: 'Unable to save syllabus.',
          btns: {
            text: 'Resave',
            icon: false,
            color: 'accent',
            cb: (sb, e) => {
              this.save()
              sb.snackbar = false
            }
          }
        })
      })
    },

    fetchCourse() {
      if (!this.assignId) {
        return
      }

      this.courseLoading = true
      this.$bus.generator.courseRefresh = true
      this.$http.post(this.courseUrl, qs.stringify({
        assignId: this.assignId
      })).then((res) => {
        console.warn(res.data)
        // hide refresh button
        this.courseLoading = false
        this.$bus.generator.courseRefresh = false

        if (!res.data.success) {
          this.course = null
          throw new Error('Request failure.')
        }

        // if syllabus exists, also add that
        if (res.data.syllabus) {
          // but first, parse that json string
          res.data.syllabus.content = JSON.parse(res.data.syllabus.content)
          this.tempSyllabus = res.data.syllabus
        }

        this.course = res.data.course
      }).catch(e => {
        console.error(e)
        this.courseLoading = false
        // show refresh button
        this.$bus.generator.courseRefresh = true
      })
    }
  }
}
</script>
