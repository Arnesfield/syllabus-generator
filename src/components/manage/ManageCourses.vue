<template>
<v-container fluid>

  <v-text-field
    solo
    label="Search course"
    prepend-icon="search"
    :append-icon="search ? 'close' : undefined"
    :append-icon-cb="() => { search ? search = null : null }"
    class="mb-2"
    ref="searchbar"
    v-model="search"
  />

  <v-data-table
    class="elevation-1"
    :loading="loading"
    :headers="headers"
    :pagination.sync="pagination"
    :items="courses">
    <template slot="no-data">
      <td colspan="100%" class="text-xs-center" :class="{ 'py-4': !loading }">
        <template v-if="loading">Loading...</template>
        <template v-else>Sorry, nothing to display here :(
          <br>
          <v-btn @click="fetch">Refresh</v-btn>
        </template>
      </td>
      <!-- <td v-if="!loading" :colspan="headers.length" style="padding: 0">
        <v-alert
          style="margin: 0"
          :value="true"
          color="error"
          icon="warning">Sorry, nothing to display here :(</v-alert>
      </td> -->
    </template>
    <template slot="items" slot-scope="props">
      <td>{{ props.item.id }}</td>
      <td>{{ props.item.code }}</td>
      <td>{{ props.item.title }}</td>
      <td>{{ props.item.unitsLec }}</td>
      <td>{{ props.item.unitsLab }}</td>
      <td>
        <div class="justify-center layout">
          <v-tooltip top>
            <template slot="activator">
              <v-icon
                v-if="props.item.status == 1"
                color="success">check_circle</v-icon>
              <v-icon
                v-else
                color="error">cancel</v-icon>
            </template>
            <span>{{ props.item.status == 1 ? 'Activated' : 'Deactivated' }}</span>
          </v-tooltip>
        </div>
      </td>
      <td class="justify-center layout px-0">
        <v-tooltip top>
          <v-btn slot="activator" icon class="mx-0" @click="editItem(props.item)">
            <v-icon color="teal">edit</v-icon>
          </v-btn>
          <span>Edit</span>
        </v-tooltip>
        <!-- <v-tooltip top>
          <v-btn slot="activator" icon class="mx-0" @click="deleteItem(props.item)">
            <v-icon color="pink">delete</v-icon>
          </v-btn>
          <span>Delete</span>
        </v-tooltip> -->
      </td>
    </template>
  </v-data-table>

  <dialog-manage-course ref="dialogManage"/>
  <dialog-csv-courses/>

</v-container>
</template>

<script>
import qs from 'qs'
import DialogManageCourse from '@/include/dialogs/DialogManageCourse'
import DialogCsvCourses from '@/include/dialogs/DialogCsvCourses'

export default {
  name: 'manage-courses',
  components: {
    DialogManageCourse,
    DialogCsvCourses
  },
  data: () => ({
    url: '/courses',
    deleteUrl: '/courses/delete',
    headers: [
      { text: 'Id', value: 'id', align: 'left', sortable: false },
      { text: 'Code', value: 'code', align: 'left' },
      { text: 'Title', value: 'title', align: 'left' },
      { text: 'Units Lec', value: 'unitsLec', align: 'left', sortable: false },
      { text: 'Units Lab', value: 'unitsLab', align: 'left', sortable: false },
      { text: 'Status', value: 'status', align: 'left', sortable: false },
      { text: 'Actions', value: 'id', sortable: false }
    ],
    courses: [],
    // for data table
    loading: null,
    pagination: {},
    limit: 5,
    offset: 1,

    search: null
  }),

  watch: {
    pagination: {
      deep: true,
      handler(e) {
        console.log(e)
        this.limit = e.rowsPerPage
        this.offset = e.page
        this.fetch()
      }
    },
    loading(e) {
      this.$bus.refresh(e)
    },
    search(e) {
      this.fetch()
    }
  },

  created() {
    this.$bus.$on('manage--courses.add', this.addItem)
    this.$bus.$on('manage--courses.upload', this.csvCourses)
    this.$bus.$on('manage--courses.update', this.fetch)
    this.$bus.$on('refresh--btn', this.fetch)
    // this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('manage--courses.add', this.addItem)
    this.$bus.$off('manage--courses.upload', this.csvCourses)
    this.$bus.$off('manage--courses.update', this.fetch)
    this.$bus.$off('refresh--btn', this.fetch)
  },

  methods: {
    deleteItem(item) {
      this.$bus.$emit('dialog--global.confirm.show', {
        item: item,
        title: 'Delete course',
        subtitle: item.code,
        msg: 'This will delete the course.',
        btn: {
          text: 'Delete',
          color: 'error'
        },
        fn: (onSuccess, onError, doClose, fn) => {
          this.$http.post(this.deleteUrl, qs.stringify({
            id: item.id
          })).then(res => {
            console.warn(res.data)
            if (!res.data.success) {
              throw new Error('Request failure.')
            }

            this.$bus.$emit('snackbar--show', 'Course deleted.')
            this.$bus.$emit('manage--courses.update')
            this.fetch()
            onSuccess()
          }).catch(e => {
            console.error(e)
            this.$bus.$emit('snackbar--show', {
              text: 'Unable to delete course.',
              btns: {
                text: 'Retry',
                icon: false,
                color: 'accent',
                cb: (sb, e) => {
                  sb.snackbar = false
                  fn(onSuccess, onError, doClose, fn)
                  // this.deleteComment(item)
                }
              }
            })
            onError()
            doClose()
          })
        }
      })
    },

    editItem(item) {
      if (this.$refs.dialogManage) {
        this.$refs.dialogManage.editItem(item)
      }
    },

    addItem() {
      if (this.$refs.dialogManage) {
        this.$refs.dialogManage.addItem()
      }
    },
    csvCourses() {
      this.$bus.dialog.ManageCourses.csv = true
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        withRelated: true,
        search: this.search,
        limit: this.limit,
        offset: this.offset
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        let courses = res.data.courses
        this.courses = typeof courses === 'object' ? courses : []
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
