<template>
<v-container
  fluid
  :style="course ? null : {
    display: 'flex',
    height: 'calc(100% - 96px)'
  }"
>
  <div
    v-if="course"
    class="my-tree-list"
  >
    <ul class="mono">
      <course-tree-view :item="course"/>
    </ul>
  </div>

  <v-layout
    justify-center
    align-center
    v-else
  >
    <manage-no-data
      class="mb-5"
      msg="Unable to load course information :("
      :loading="loading"
      :fetch="fetch"
    />
  </v-layout>

  <dialog-detailed-course ref="dialog"/>

</v-container>
</template>

<script>
import qs from 'qs'
import DialogDetailedCourse from '@/include/dialogs/DialogDetailedCourse'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'course-tree',
  components: {
    DialogDetailedCourse,
    ManageNoData
  },
  props: {
    courseId: {
      type: String,
      default: undefined
    }
  },
  data: () => ({
    url: '/courses',
    course: null,
    loading: false
  }),
  watch: {
    courseId(e) {
      e ? this.fetch() : undefined
    }
  },

  created() {
    this.$bus.$on('refresh--btn', this.fetch)
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
    this.$bus.toolbar.titleContent = null
  },

  methods: {
    clear() {
      this.course = null
      this.$bus.toolbar.titleContent = null
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        deep: true,
        withRelated: true,
        cid: this.courseId
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        if (res.data.courses.length) {
          this.course = res.data.courses[0]
          this.$bus.toolbar.titleContent = this.course.code
        }
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }

}
</script>
