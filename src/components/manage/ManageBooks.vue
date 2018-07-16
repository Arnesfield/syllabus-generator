<template>
<v-container fluid>

  <v-text-field
    solo
    label="Search book"
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
      <td class="px-0">
        <v-layout justify-center align-center>
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
        </v-layout>
      </td>
    </template>
  </v-data-table>

  <dialog-manage-book ref="dialogManage"/>
  <dialog-csv-books/>

</v-container>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import DialogManageBook from '@/include/dialogs/DialogManageBook'
import DialogCsvBooks from '@/include/dialogs/DialogCsvBooks'

export default {
  name: 'manage-books',
  components: {
    DialogManageBook,
    DialogCsvBooks
  },
  data: () => ({
    url: '/books',
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
    this.$bus.$on('manage--books.add', this.addItem)
    this.$bus.$on('manage--books.upload', this.csvBooks)
    this.$bus.$on('manage--books.update', this.fetch)
    this.$bus.$on('refresh--btn', this.fetch)
    // this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('manage--books.add', this.addItem)
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
      if (this.$refs.dialogManage) {
        this.$refs.dialogManage.editItem(item)
      }
    },

    addItem() {
      if (this.$refs.dialogManage) {
        this.$refs.dialogManage.addItem()
      }
    },
    csvBooks() {
      this.$bus.dialog.ManageBooks.csv = true
    },

    fetch: debounce(function() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        only: true,
        search: this.search,
        limit: this.limit,
        offset: this.offset
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        let books = res.data.books
        this.books = typeof books === 'object' ? books : []
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300)
  }
}
</script>
