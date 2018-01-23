<template>
<div>
  <v-data-table
    class="elevation-1"
    :loading="loading"
    :headers="headers"
    :pagination.sync="pagination"
    :items="users">
    <template slot="no-data">
      <div class="body-1text-xs-center">Sorry, nothing to display here :(</div>
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
    </template>
  </v-data-table>
</div>
</template>

<script>
export default {
  name: 'manage-users',
  data: () => ({
    url: '/users',
    headers: [
      { text: 'Id', value: 'id', align: 'left', sortable: false },
      { text: 'Image', value: 'img_src', align: 'left', sortable: false },
      { text: 'First Name', value: 'fname', align: 'left' },
      { text: 'Middle Name', value: 'mname', align: 'left' },
      { text: 'Surname', value: 'lname', align: 'left' },
      { text: 'Username', value: 'username', align: 'left' },
      { text: 'Type', value: 'type', align: 'left', sortable: false },
      { text: 'Status', value: 'status', align: 'left', sortable: false }
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
    this.fetch()
  },

  methods: {
    fetch() {
      this.$http.post(this.url).then((res) => {
        let users = res.data.users
        this.users = typeof users === 'object' ? users : []
        this.currId = res.data.currId
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
