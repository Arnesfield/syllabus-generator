<template>
<v-container fluid>

  <v-text-field
    solo
    label="Search user"
    prepend-icon="search"
    :append-icon="search ? 'close' : undefined"
    :append-icon-cb="() => { search ? search = null : null }"
    class="mb-2"
    ref="searchbar"
    v-model="search"
  />

  <v-data-table
    class="elevation-1 mb-2"
    :loading="loading"
    :headers="headers"
    :pagination.sync="pagination"
    :items="logs"
  >
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
      <td>
        <span class="none">{{ props.item.created_at }}</span>
        <div v-html="$moment.unix(props.item.created_at).format('MMMM DD, YYYY h:mm A')"></div>
      </td>
      <td>{{ props.item.user_id }}</td>
      <td>
        <template v-if="props.item.img_src.length">
          <icon-img
            class="ma-2"
            size="32"
            :item="props.item"
            :alt="props.item.username"
          />
        </template>
        <pre v-else>No image.</pre>
      </td>
      <td>
        <a
          @click="selectedUser = props.item.user_id"
          style="text-decoration: underline"
        >{{ $wrap.fullname(props.item) }}</a>
      </td>
      <td>{{ props.item.username }}</td>
      <td>{{ props.item.title }}</td>
      <td>
        <v-layout justify-center>
          <v-chip
            label
            small
            text-color="white"
            :color="props.item.type == 1 ? 'success' : 'error'"
          >
            <template v-if="props.item.type == 1">In</template>
            <template v-else>Out</template>
          </v-chip>
        </v-layout>
      </td>
    </template>
  </v-data-table>

  <template v-if="selectedUser">
    <v-divider class="my-3"/>
    <user-logs-graph
      :id="selectedUser"
      log-in
      log-out
      class="mb-5"
    />
  </template>

</v-container>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import IconImg from '@/include/IconImg'
import UserLogsGraph from '@/include/graphs/UserLogsGraph'

export default {
  name: 'user-logs',
  components: {
    IconImg,
    UserLogsGraph
  },
  props: {
    userId: {
      type: [String, Number],
      default: null
    }
  },
  data: () => ({
    url: '/logs/user',
    headers: [
      { text: 'Datetime', value: 'created_at', align: 'left', sortable: false },
      { text: 'User Id', value: 'user_id', align: 'left', sortable: false },
      { text: 'Image', value: 'img_src', align: 'left', sortable: false },
      { text: 'Name', value: 'fname', align: 'left' },
      { text: 'Username', value: 'username', align: 'left' },
      { text: 'Title', value: 'title', align: 'left', sortable: false },
      { text: 'Type', value: 'type', align: 'left', sortable: false }
    ],
    logs: [],

    selectedUser: null,

    loading: false,
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
    userId(e) {
      this.selectedUser = e
    },
    loading(e) {
      this.$bus.refresh(e)
    },
    search(e) {
      this.fetch()
    }
  },

  created() {
    this.selectedUser = this.userId
    // this.fetch()
  },

  methods: {
    fetch: debounce(function() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: this.search,
        limit: this.limit,
        offset: this.offset
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.logs = res.data.logs
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300)
  }
}
</script>
