<template>
<v-container
  fluid
  :class="{ 'pa-0': syllabus && assign && course }"
  :style="!(syllabus && assign && course) ? {
    height: 'calc(100% - 96px)'
  } : null"
>

  <template v-if="syllabus && assign && course">
    <syllabus-inst
      ref="syllabusInst"
      :assign="assign"
      v-model="syllabus"
      style="margin: 0 auto"
      :pdf.sync="pdf"
      standardHeight="calc(100vh - 96px)"
      pdfHeight="calc(100vh - 96px)"
    />
  </template>

  <v-layout
    v-else
    justify-center
    align-center
    class="full-height"
  >
    <manage-no-data
      :fetch="fetch"
      :loading="loading"
      msg="Unable to load syllabus. It might not exist :("
    />
  </v-layout>

  <dialog-detailed-course ref="dialogCourse"/>

</v-container>
</template>

<script>
import qs from 'qs'
import find from 'lodash/find'
import SyllabusInst from '@/include/SyllabusInst'
import ManageNoData from '@/include/ManageNoData'
import DialogDetailedCourse from '@/include/dialogs/DialogDetailedCourse'

export default {
  name: 'syllabus',
  components: {
    SyllabusInst,
    ManageNoData,
    DialogDetailedCourse
  },
  props: {
    courseId: String,
    syllabusId: String,
  },
  data: () => ({
    url: '/courses',
    assign: null,
    course: null,
    syllabus: null,
    pdf: false,
    loading: false
  }),
  watch: {
    courseId(e) {
      this.fetch()
    },
    syllabusId(e) {
      this.fetch()
    },
    loading(e) {
      this.$bus.refresh(e)
    }
  },

  created() {
    this.$bus.$on('refresh--btn', this.fetch)
    this.$bus.$on('syllabus--info.show', this.infoShow)
    this.$bus.$on('syllabus--pdf.toggle', this.pdfToggle)
    this.fetch()
    // reset
    this.$bus.toolbar.comments.pdf = false
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
    this.$bus.$off('syllabus--info.show', this.infoShow)
    this.$bus.$off('syllabus--pdf.toggle', this.pdfToggle)
    this.$bus.toolbar.titleContent = null
  },

  methods: {
    infoShow() {
      if (!this.course) {
        return
      }
      if (this.$refs.dialogCourse) {
        this.$refs.dialogCourse.viewItem(this.course.id)
      }
    },
    pdfToggle() {
      this.$bus.toolbar.comments.pdf = !this.$bus.toolbar.comments.pdf
      this.pdf = this.$bus.toolbar.comments.pdf
      if (this.$refs.syllabusInst) {
        this.$refs.syllabusInst.generate(this.pdf)
      }
    },

    clear() {
      this.assign = null
      this.course = null
      this.syllabus = null
      this.$bus.toolbar.titleContent = null
    },

    fetch() {
      if (this.pdf) {
        // turn it off
        this.pdfToggle()
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        cid: this.courseId,
        sid: this.syllabusId,
        withRelated: true,
        withSyllabi: true,
        formatSyllabi: true,
        withAssign: true,
        logSyllabus: true
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        if (res.data.courses.length) {
          this.course = res.data.courses[0]
          // get assign and syllabi
          this.assign = this.course.assign
          this.syllabus = find(this.course.syllabi, { id: this.syllabusId })

          // set custom title
          this.$bus.toolbar.titleContent = this.course.code + ' v' + this.syllabus.version
        }
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.clear()
        this.loading = false
      })
    }
  }
}
</script>
