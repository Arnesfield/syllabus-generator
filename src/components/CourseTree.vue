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
    style="overflow-x: auto"
  >
    <ul class="mono">
      <course-tree-view
        :item="course"
        @select="select"
        :selected-id="id"
      />
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

  <sidenav-course :course-id.sync="id"/>
  <dialog-detailed-course ref="dialog"/>

</v-container>
</template>

<script>
import qs from 'qs'
import SidenavCourse from '@/include/SidenavCourse'
import DialogDetailedCourse from '@/include/dialogs/DialogDetailedCourse'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'course-tree',
  components: {
    SidenavCourse,
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
    id: undefined,
    course: null,
    loading: false
  }),
  watch: {
    loading(e) {
      this.$bus.refresh(e)
    },
    courseId(e) {
      e ? this.fetch() : undefined
    }
  },

  created() {
    this.$bus.$on('refresh--btn', this.fetch)
    this.id = this.courseId
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
    this.$bus.toolbar.titleContent = null
    this.$bus.toolbar.course.collapse = false
    this.$bus.toolbar.course.model = null
  },

  methods: {
    select(id) {
      this.id = id
    },

    clear() {
      this.course = null
      this.$bus.toolbar.titleContent = null
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        deep: true,
        withRelated: true,
        cid: this.courseId,
        log: true
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
