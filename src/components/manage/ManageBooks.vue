<template>
<v-container fluid>
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
        <v-tooltip top>
          <v-btn slot="activator" icon class="mx-0" @click="editItem(props.item)">
            <v-icon color="teal">edit</v-icon>
          </v-btn>
          <span>Edit</span>
        </v-tooltip>
        <v-tooltip top>
          <v-btn slot="activator" icon class="mx-0" @click="deleteItem(props.item)">
            <v-icon color="pink">delete</v-icon>
          </v-btn>
          <span>Delete</span>
        </v-tooltip>
      </td>
    </template>
  </v-data-table>

  <dialog-add-book/>
  <dialog-csv-books/>

</v-container>
</template>

<script>
import qs from 'qs'
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
    deleteUrl: '/books/delete',
    headers: [
      { text: 'Id', value: 'id', align: 'left', sortable: false },
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
    },
    loading(e) {
      this.$bus.refresh(e)
    }
  },

  created() {
    this.$bus.$on('manage--books.add', this.addBook)
    this.$bus.$on('manage--books.upload', this.csvBooks)
    this.$bus.$on('manage--books.update', this.fetch)
    this.$bus.$on('refresh--btn', this.fetch)
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('manage--books.add', this.addBook)
    this.$bus.$off('manage--books.upload', this.csvBooks)
    this.$bus.$off('manage--books.update', this.fetch)
    this.$bus.$off('refresh--btn', this.fetch)
  },

  methods: {
    deleteItem(item) {
      this.$bus.$emit('dialog--global.confirm.show', {
        item: item,
        title: 'Delete book',
        subtitle: item.citation,
        msg: 'This will delete the book.',
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

            this.$bus.$emit('snackbar--show', 'Book deleted.')
            this.$bus.$emit('manage--books.update')
            this.fetch()
            onSuccess()
          }).catch(e => {
            console.error(e)
            this.$bus.$emit('snackbar--show', {
              text: 'Unable to delete book.',
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

    },

    addBook() {
      this.$bus.dialog.ManageBooks.add = true
    },
    csvBooks() {
      this.$bus.dialog.ManageBooks.csv = true
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
