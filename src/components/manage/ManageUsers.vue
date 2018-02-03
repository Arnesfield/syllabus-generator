<template>
<div>
  <v-data-table
    class="elevation-1"
    :loading="loading"
    :headers="headers"
    :pagination.sync="pagination"
    :items="users">
    <template slot="no-data">
      <td colspan="100%" class="text-xs-center" :class="{ 'py-4': !loading }">
        <template v-if="loading">Loading...</template>
        <template v-else>Sorry, nothing to display here :(
          <br>
          <v-btn @click="fetch">Refresh</v-btn>
        </template>
      </td>
      <!-- <td v-else colspan="100%">
        <v-alert
          style="margin: 0"
          :value="true"
          color="error"
          icon="warning"></v-alert>
      </td> -->
    </template>
    <template slot="items" slot-scope="props">
      <td>{{ props.item.id }}</td>
      <td>
        <template v-if="props.item.img_src.length">
          <img
            class="tbl-img"
            :src="'./uploads/' + props.item.img_src"
            :alt="props.item.username">
        </template>
        <pre v-else>No image.</pre>
      </td>
      <td>{{ props.item.fname }}</td>
      <td>{{ props.item.mname }}</td>
      <td>{{ props.item.lname }}</td>
      <td>{{ props.item.username }}</td>
      <td>{{ props.item.type }}</td>
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

  <add-user/>

</div>
</template>

<script>
import AddUser from '@/include/dialogs/AddUser'

export default {
  name: 'manage-users',
  components: {
    AddUser
  },
  data: () => ({
    url: '/users',
    headers: [
      { text: 'Id', value: 'id', align: 'left' },
      { text: 'Image', value: 'img_src', align: 'left', sortable: false },
      { text: 'First Name', value: 'fname', align: 'left' },
      { text: 'Middle Name', value: 'mname', align: 'left' },
      { text: 'Surname', value: 'lname', align: 'left' },
      { text: 'Username', value: 'username', align: 'left' },
      { text: 'Type', value: 'type', align: 'left', sortable: false },
      { text: 'Status', value: 'status', align: 'left', sortable: false },
      { text: 'Actions', value: 'id', sortable: false }
    ],
    users: [],
    currId: null,
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
    this.$bus.$on('on-fab-manage-users-person-add', this.addUser)
    this.fetch()
  },

  methods: {
    addUser() {
      this.$bus.dialog.addUser.model = true
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then((res) => {
        let users = res.data.users
        this.users = typeof users === 'object' ? users : []
        this.currId = res.data.currId
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
