<template>
<div>
  <v-data-table
    class="elevation-1"
    :loading="loading"
    :headers="headers"
    :pagination.sync="pagination"
    :items="books">
    <template slot="no-data">
      <td colspan="100%" class="text-xs-center" :class="{ 'py-4': !loading }">
        <template v-if="loading">Loading...</template>
        <template v-else>Sorry, nothing to display here :(
          <br>
          <v-btn @click="fetch">Refresh</v-btn>
        </template>
      </td>
    </template>
    <template slot="items" slot-scope="props">
      <td>{{ props.item.id }}</td>
      <td>{{ props.item.citation }}</td>
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
        <v-btn icon class="mx-0">
          <v-icon color="teal">edit</v-icon>
        </v-btn>
        <v-btn icon class="mx-0">
          <v-icon color="pink">delete</v-icon>
        </v-btn>
      </td>
    </template>
  </v-data-table>

  <dialog-add-book/>
  <dialog-csv-books/>

</div>
</template>

<script>
import DialogAddBook from '@/include/dialogs/DialogAddBook'
import DialogCsvBooks from '@/include/dialogs/DialogCsvBooks'

export default {
  name: 'manage-books',
  components: {
    DialogAddBook,
    DialogCsvBooks
  },
  data: () => ({
    url: '/books/only',
    headers: [
      { text: 'Id', value: 'id', align: 'left' },
      { text: 'Citation', value: 'citation', align: 'left' },
      { text: 'Status', value: 'status', align: 'left', sortable: false },
      { text: 'Actions', value: 'id', sortable: false }
    ],
    books: [],
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
    this.$bus.$on('fab-manage-books-book-add', this.addBook)
    this.$bus.$on('fab-manage-books-file-upload', this.csvBook)
    this.$bus.$on('update-manage-books', this.fetch)
    this.fetch()
  },

  methods: {
    addBook() {
      this.$bus.dialog.addBook.model = true
    },
    csvBook() {
      this.$bus.dialog.csvBook.model = true
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then((res) => {
        let books = res.data.books
        this.books = typeof books === 'object' ? books : []
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
