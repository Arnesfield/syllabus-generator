<template>
<v-container
  grid-list-lg
  :style="items.length ? null : {
    display: 'flex',
    height: 'calc(100% - 96px)'
  }"
>
  <v-layout
    row
    wrap
    v-if="items.length"
    class="mb-3"
  >
    <v-flex
      xs12
      sm6
      md4
      :key="i"
      v-for="(item, i) in items"
    >
      <course-info-view
        slim
        class="pa-2"
        :item="item"
        @view="viewItem"
        style="height: 100%"
      />
    </v-flex>
  </v-layout>

  <v-layout
    justify-center
    align-center
    v-else
  >
    <manage-no-data
      class="mb-5"
      msg="No courses :("
      :loading="loading"
      :fetch="fetch"
    />
  </v-layout>

  <dialog-detailed-course ref="dialog"/>

</v-container>
</template>

<script>
import qs from 'qs'
import CourseInfoView from '@/include/CourseInfoView'
import DialogDetailedCourse from '@/include/dialogs/DialogDetailedCourse'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'courses',
  components: {
    CourseInfoView,
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
    items: [],
    loading: false
  }),
  watch: {
    courseId(e) {
      e ? this.viewItem(e) : undefined
    }
  },

  created() {
    this.$bus.$on('search', this.fetch)
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('search', this.fetch)
  },

  mounted() {
    if (this.courseId) {
      this.viewItem(this.courseId)
    }
  },

  methods: {
    viewItem(item) {
      let id = typeof item === 'object' ? item.id : item
      if (this.$refs.dialog) {
        // only use id
        this.$refs.dialog.viewItem(id)
      }
    },

    fetch(search) {
      if (typeof search !== 'string' && !search) {
        if (typeof this.$bus.search.input === 'string') {
          search = this.$bus.search.input
        } else {
          search = ''
        }
      }

      if (typeof search !== 'string') {
        search = ''
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.items = res.data.courses
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }

}
</script>
