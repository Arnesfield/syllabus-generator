<template>
<v-container
  fluid
  :style="!course ? {
    display: 'flex',
    width: '100%',
    height: $bus.tabs.Generator.tabs ? 'calc(100% - 96px)' : 'calc(100% - 64px)'
  } : null"
  class="smooth-padding"
  :class="{ 'pa-0': fabNextStateSubmit }"
>

  <template v-if="allowEdit && course">
    <suggest-alert/>

    <v-tabs-items
      v-model="$bus.tabs.Generator.tab"
      style="overflow: visible"
    >

      <!-- course -->

      <v-tab-item>
        <course-view v-model="course"/>
      </v-tab-item>

      <!-- syllabus -->

      <v-tab-item>
        <syllabus-picker
          v-model="syllabus"
          :course="course"
          :syllabus-content="syllabusContent"
        />
      </v-tab-item>

      <template v-if="syllabus">
        
        <!-- books -->

        <v-tab-item>
          <book-picker :syllabus="syllabus"/>
        </v-tab-item>

        <!-- curriculum -->

        <v-tab-item>
          <curriculum-picker :syllabus="syllabus"/>
        </v-tab-item>

        <!-- if po is set -->

        <template v-if="syllabus.content && syllabus.content.programOutcomes">

          <!-- clo -->

          <v-tab-item>
            <clo-view v-model="syllabus"/>
          </v-tab-item>

          <!-- activity -->

          <v-tab-item>
            <activity-manager :syllabus="syllabus"/>
          </v-tab-item>

          <!-- grading -->

          <v-tab-item>
            <grading-system :syllabus="syllabus"/>
          </v-tab-item>

          <!-- preview -->

          <v-tab-item>
            <syllabus-preview
              :syllabus="syllabus"
              @submit="submit"
            />
          </v-tab-item>

        </template>

      </template>
    </v-tabs-items>

    <!-- fab -->

    <v-tooltip left>
      <v-btn
        fab
        fixed
        bottom
        right
        color="accent"
        slot="activator"
        :disabled="!fabNextStateSubmit && fabNextStateLast"
        @click="fabNextAction"
      >
        <v-icon v-if="!fabNextStateSubmit">navigate_next</v-icon>
        <v-icon v-else>send</v-icon>
      </v-btn>
      <span v-if="!fabNextStateSubmit">Next</span>
      <span v-else>Submit for approval</span>
    </v-tooltip>

  </template>

  <v-layout
    justify-center
    align-center
    v-else
  >
    <manage-no-data
      v-if="allowEdit || allowEdit === null"
      msg="Unable to load information :("
      :fetch="fetch"
      :loading="loading"
    >
      <v-icon
        slot="icon"
        size="64px"
        class="mb-4"
      >sync_disabled</v-icon>
    </manage-no-data>
    <manage-no-data
      v-else
      msg="<div>The syllabus you are trying to edit is already submitted.</div><div>You may view the syllabus instead.</div>"
      :fetch="fetch"
      :loading="loading"
    >
      <v-icon
        slot="icon"
        size="64px"
        class="mb-4"
      >warning</v-icon>
      <v-btn
        slot="btn"
        color="primary lighten-1"
        :to="'/syllabus/' + assignId"
      >View syllabus</v-btn>
    </manage-no-data>
  </v-layout>

  <dialog-detailed-workflow view-only/>
  <dialog-workflow-logs/>

</v-container>
</template>

<script>
import qs from 'qs'
import ManageNoData from '@/include/ManageNoData'
import DialogWorkflowLogs from '@/include/dialogs/DialogWorkflowLogs'
import DialogDetailedWorkflow from '@/include/dialogs/DialogDetailedWorkflow'
import SuggestAlert from '@/include/generator/SuggestAlert'

import CourseView from '@/components/generator/CourseView'
import CurriculumPicker from '@/components/generator/CurriculumPicker'
import SyllabusPicker from '@/components/generator/SyllabusPicker'
import BookPicker from '@/components/generator/BookPicker'
import CloView from '@/components/generator/CloView'
import ActivityManager from '@/components/generator/ActivityManager'
import GradingSystem from '@/components/generator/GradingSystem'
import SyllabusPreview from '@/components/generator/SyllabusPreview'

export default {
  name: 'generator',
  components: {
    ManageNoData,
    DialogWorkflowLogs,
    DialogDetailedWorkflow,
    SuggestAlert,

    CourseView,
    CurriculumPicker,
    SyllabusPicker,
    BookPicker,
    CloView,
    ActivityManager,
    GradingSystem,
    SyllabusPreview
  },
  props: {
    assignId: String
  },
  data: () => ({
    url: '/generation',
    submitUrl: '/syllabi/submit',
    saveUrl: '/syllabi/save',

    assign: null,
    course: null,
    syllabus: null,
    syllabusContent: null,

    // for navigation
    tabs: {
      info: ['info'],
      course: ['course'],
      syllabi: ['course', 'syllabi'],
      noCurriculum: ['course', 'syllabi', 'books', 'curriculum'],
      all: ['course', 'syllabi', 'books', 'curriculum', 'clo', 'activities', 'grading', 'done']
    },

    loading: false,
    saveLoading: false,
    allowEdit: null
  }),
  computed: {
    fabNextStateSubmit() {
      return this.tabs.all.length-1 == this.$bus.tabs.Generator.tab
    },
    fabNextStateLast() {
      return this.$bus.tabs.Generator.items.length-1 == this.$bus.tabs.Generator.tab
    }
  },
  watch: {
    loading(e) {
      this.$bus.refresh(e)
    },
    saveLoading(e) {
      this.$bus.progress.circular.Generator.save = e
    },
    allowEdit(e) {
      this.$bus.generator.allowEdit = e
      this.setTabs()
    },

    course(e) {
      // hide refresh btn when course is set
      this.$bus.generator.courseRefresh = !e
      this.setTabs()
    },
    syllabus: {
      deep: true,
      handler: function(e) {
        this.setTabs()
      }
    },

    '$bus.tabs.Generator.tab': function(e) {
      if (this.$bus.tabs.Generator.tabs) {
        this.$vuetify.goTo('#app', {
          duration: 400,
          offset: 0,
          easing: 'easeInOutCubic'
        })
      }
    }
  },

  created() {
    this.$bus.$on('generator--save', this.save)
    this.$bus.$on('generator--info.show', this.infoShow)
    this.$bus.$on('generator--undo', this.undo)
    this.$bus.$on('refresh--btn', this.fetch)
    this.resetTabs()
    this.setInitial()
    this.fetch()

    // move the nav drawer
    if (this.$bus.nav.model) {
      this.$bus.nav.model = null
      this.$bus.nav.miniVariant = true
    }
  },
  beforeDestroy() {
    this.$bus.$off('generator--save', this.save)
    this.$bus.$off('generator--info.show', this.infoShow)
    this.$bus.$off('generator--undo', this.undo)
    this.$bus.$off('refresh--btn', this.fetch)

    // reset bus defaults
    this.resetTabs()
    this.$bus.generator.suggestions = true
    this.$bus.generator.courseRefresh = false
    this.$bus.toolbar.titleContent = null
  },

  methods: {
    setInitial() {
      this.$bus.generator.courseRefresh = true
    },

    setTabs() {
      // only set tabs if course is set
      if (this.course) {
        this.$bus.tabs.Generator.tabs = true
        let s = this.syllabus
        if (!s) {
          this.$bus.tabs.Generator.items = this.tabs.syllabi
        } else {
          if (s.content) {
            // attach course to syllabus
            this.$set(this.syllabus.content, 'course', this.course)
          }

          if (
            s.content &&
            s.content.programOutcomes &&
            s.content.programOutcomes.content
          ) {
            this.$bus.tabs.Generator.items = this.tabs.all
          } else {
            this.$bus.tabs.Generator.items = this.tabs.noCurriculum
          }
        }
      }
      // if course not set
      else {
        this.resetTabs()
      }
    },

    resetTabs() {
      if (this.$bus.tabs.Generator.tab !== null) {
        this.$bus.tabs.Generator.tab = null
        this.$bus.tabs.Generator.tabs = null
        this.$bus.tabs.Generator.items = null
      }
    },

    resetData() {
      this.course = null
      this.syllabus = null
      this.allowEdit = null
    },

    infoShow() {
      if (!this.assign) {
        return
      }
      this.$bus.$emit('dialog--detailed-workflow.show', this.assign)
    },

    fabNextAction() {
      if (!this.fabNextStateSubmit) {
        this.$bus.tabs.Generator.tab = String(Number(this.$bus.tabs.Generator.tab) + 1)
      } else {
        // submit mode
        this.submit()
      }
    },

    stringifySyllabus(syllabus) {
      return JSON.stringify(syllabus.content || syllabus)
    },

    save() {
      if (!this.allowEdit || !this.syllabus) {
        this.fetch()
        return
      }

      let syllabus = this.stringifySyllabus(this.syllabus)
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
        this.$bus.$emit('snackbar--show', 'Syllabus progress saved.')
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

    undo() {
      this.$bus.$emit('dialog--global.confirm.show', {
        title: 'Undo syllabus',
        msg: `
          This will load the last saved syllabus.
          Your current work
            <strong class="warning--text">won\'t be saved</strong>.
        `,
        btn: {
          text: 'Undo',
          color: 'warning'
        },
        fn: (onSuccess, onError, doClose, fn) => {
          onSuccess()
          this.fetch(null)
        }
      })
    },

    submit() {
      // handle submit
      console.log(this.syllabus)

      if (!this.assignId || !this.syllabus) {
        return
      }

      this.$bus.$emit('dialog--global.confirm.show', {
        title: 'Submit syllabus',
        msg: `
          This syllabus will be submitted for approval.
          You
            <strong class="warning--text">won\'t be able to edit</strong>
          this syllabus when it is under the approval process.
        `,
        btn: {
          text: 'Submit',
          color: 'primary lighten-1'
        },
        fn: (onSuccess, onError, doClose, fn) => {
          let syllabus = this.stringifySyllabus(this.syllabus)
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
            this.fetch('Syllabus submitted for approval.')
            onSuccess()
            // this.$bus.$emit('snackbar--show', 'Syllabus submitted.')
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
                  sb.snackbar = false
                  fn(onSuccess, onError, doClose, fn)
                  // this.submit()
                }
              }
            })
            onError()
            doClose()
          })
        }
      })
    },

    fetch(msg) {
      if (typeof msg !== 'string') {
        msg = null
      }

      // reset first
      this.resetData()

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        assignId: this.assignId
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }

        let course = res.data.course
        let assign = res.data.assign
        this.assign = assign

        // if disapproved or not yet submitted, allow edit
        if (assign.status == 0 || assign.status == 3) {
          this.allowEdit = true

          // if syllabus exists, set
          if (res.data.syllabus) {
            this.syllabus = res.data.syllabus

            // if course in syllabus is set, set that instead in course
            course = res.data.syllabus.content.course || course
          }

          // then finally set the course
          this.course = course
          // set syllabus content
          this.syllabusContent = res.data.syllabusContent
        } else {
          this.resetData()
          this.$bus.$emit('snackbar--show', msg || 'You cannot edit a submitted syllabus.')
        }

        // set course code
        this.$bus.toolbar.titleContent = course.code

        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      }) 
    }
  }
}
</script>
