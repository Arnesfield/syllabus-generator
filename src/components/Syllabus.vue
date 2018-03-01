<template>
<div
  :style="!syllabus ? {
    height: 'calc(100% - 96px)'
  } : null"
>

  <template v-if="syllabus">
    <syllabus-inst
      ref="syllabusInst"
      :syllabus="syllabus"
      style="margin: 0 auto"
      :pdf.sync="pdf"
      standardHeight="calc(100vh - 112px)"
      pdfHeight="calc(100vh - 112px)"
    />
    <sidenav-comment :assignId="assignId"/>
  </template>

  <v-container
    fluid
    :fill-height="true"
    v-if="!syllabus"
  >
    <v-layout justify-center align-center>
      <manage-no-data
        :fetch="fetch"
        :loading="loading"
        msg="Unable to load syllabus. It might not exist :("
      />
    </v-layout>
  </v-container>

  <dialog-detailed-workflow/>

</div>
</template>

<script>
import qs from 'qs'
import SyllabusInst from '@/include/SyllabusInst'
import SidenavComment from '@/include/SidenavComment'
import ManageNoData from '@/include/ManageNoData'
import DialogDetailedWorkflow from '@/include/dialogs/DialogDetailedWorkflow'

export default {
  name: 'syllabus',
  props: {
    assignId: [Number, String]
  },
  components: {
    SyllabusInst,
    SidenavComment,
    ManageNoData,
    DialogDetailedWorkflow
  },
  data: () => ({
    url: '/syllabus',
    syllabus: null,
    pdf: false,

    loading: false
  }),

  watch: {
    assignId(to, from) {
      if (to !== null) {
        this.syllabus = null
        this.pdf = false
        this.fetch()
      }
    }
  },

  created() {
    this.$bus.$on('syllabus--pdf.toggle', () => {
      this.$bus.toolbar.comments.pdf = !this.$bus.toolbar.comments.pdf
      this.pdf = this.$bus.toolbar.comments.pdf
      if (this.$refs.syllabusInst) {
        this.$refs.syllabusInst.generate(this.pdf)
      }
    })
    this.fetch()
    // reset
    this.$bus.toolbar.comments.pdf = false
  },

  methods: {
    fetch() {
      if (!this.assignId) {
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        assignId: this.assignId
      })).then(res => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.syllabus = res.data.syllabus
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
