<template>
<div>
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
        <v-tooltip top>
          <v-switch
            slot="activator"
            v-model="props.item.status"/>
          <span>{{ props.item.status == 1 ? 'Actived' : 'Deactivated' }}</span>
        </v-tooltip>
      </td>
      <td class="justify-center layout px-0">
        <v-btn icon class="mx-0">
          <v-icon color="teal">edit</v-icon>
        </v-btn>
        <v-btn icon class="mx-0">
          <v-icon color="pink">delete</v-icon>
        </v-btn>
      </td>
    </template>
  </v-data-table>
</div>
</template>

<script>
export default {
  name: 'manage-courses',
  data: () => ({
    url: '/courses',
    headers: [
      { text: 'Id', value: 'id', align: 'left' },
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
    pagination: {}
  }),

  watch: {
    pagination: {
      deep: true,
      handler() {
        console.log(this.pagination)
      }
    }
  },

  created() {
    this.fetch()
  },

  methods: {
    fetch() {
      this.loading = true
      this.$http.post(this.url).then((res) => {
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
