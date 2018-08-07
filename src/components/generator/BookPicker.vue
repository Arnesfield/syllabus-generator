<template>
<div v-if="syllabus">

  <div class="pa-2">
    <v-list class="elevation-1 py-0" two-line>
      <v-list-tile
        ripple
        @click="dialog = true"
      >
        <v-list-tile-action class="thin-action">
          <v-tooltip top>
            <v-btn
              icon
              flat
              slot="activator"
              color="primary"
              @click="dialog = true"
            >
              <v-icon>library_books</v-icon>
            </v-btn>
            <span>Add book</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title
            v-text="'Selected books'"
            class="primary--text text--lighten-1"
          />
          <v-list-tile-sub-title v-text="'Total books selected: ' + selected.length"/>
        </v-list-tile-content>
      </v-list-tile>
      <template v-for="(t, i) in selected">
        <v-divider :key="'divider-' + i"/>
        <v-layout
          :key="'layout-' + i"
          align-center
          class="pr-2"
          style=""
        >
          <v-tooltip top style="align-self: flex-start">
            <v-btn
              icon
              flat
              small
              color="error"
              slot="activator"
              @click="selected.splice(i, 1)"
            >
              <v-icon small>close</v-icon>
            </v-btn>
            <span>Remove</span>
          </v-tooltip>
          <markdown-textarea
            v-model="selected[i]"
            edit-on-click
          />
        </v-layout>
      </template>
    </v-list>
  </div>

  <v-layout class="height-padding">
    <v-spacer/>
    <v-btn
      color="primary lighten-1"
      @click="dialog = true"
    >
      <v-icon>library_books</v-icon>&nbsp;
      <span>Add Book</span>
    </v-btn>
  </v-layout>

  <v-dialog
    v-model="dialog"
    width="800"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search keyword or enter book"
      :prepend-icon="search ? 'add' : 'search'"
      :prepend-icon-cb="search ? enterSearch : undefined"
      :append-icon="search ? 'close' : undefined"
      :append-icon-cb="search ? () => { search = null } : undefined"
      v-model="search"
      @keypress.enter.native="enterSearch"
      :loading="loading"
    />

    <v-progress-linear
      :active="loading"
      :indeterminate="true"
      color="accent"
      class="my-0"
      :height="loading ? 3 : 0"
      background-color="white"
    />

    <select-list
      v-model="selected"
      :items="selected"
      id="selected-book-"
      max-height="25vh"
      delete-mode
      editable
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong v-text="selected.length"/>&nbsp;Selected</template>
      <template
        slot="item"
        slot-scope="props"
      >
        <markdown-textarea
          edit-on-click
          v-model="selected[props.index]"
        />
      </template>
    </select-list>

    <select-list
      v-model="selected"
      :items.sync="books"
      id="book-"
      max-height="25vh"
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong
        v-text="books.length"
      />&nbsp;{{ search ? 'Results' : 'Suggested' }}</template>
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
        v-html="$md.makeHtml(props.item)"
      />
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'book-picker',
  components: {
    SelectList,
    MarkdownTextarea
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    url: '/books',
    suggestUrl: '/books/suggest',
    books: [],
    selected: [],
    limit: 30,
    
    dialog: false,
    search: null,
    loading: false
  }),

  watch: {
    syllabus(to, from) {
      // if null, just clear
      this.clear()
      if (to !== null) {
        this.selected = this.syllabus.content.bookReferences
        this.suggest()
      }
    },

    selected(to, from) {
      // set changes to syllabus content
      this.syllabus.content.bookReferences = to
    },
    dialog(e) {
      if (e) {
        this.suggest()
        setTimeout(() => {
          if (this.$refs.searchbar) {
            this.$refs.searchbar.focus()
          }
        })
      } else {
        this.search = null
      }
    },
    search(e) {
      this.loading = true
      this.query()
    }
  },

  created() {
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)
    if (this.syllabus !== null) {
      // set selected as book content from syllabus
      if (this.syllabus.content === null) {
        this.syllabus.content = {}
      }
      if (!this.syllabus.content.bookReferences) {
        this.$set(this.syllabus.content, 'bookReferences', [])
      }
      this.selected = this.syllabus.content.bookReferences
      this.suggest()
    }
  },
  beforeDestroy() {
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },
 
  methods: {
    enterSearch() {
      this.selected.indexOf(this.search) == -1 ? this.selected.push(this.search) : undefined
    },

    clear() {
      this.books = []
      this.selected = []
    },

    filterSearch(item, queryText, itemText) {
      console.log(item)
      const hasValue = val => val != null ? val : ''
      const citation = hasValue(item.citation).toString().toLowerCase()
      const query = hasValue(queryText).toString().toLowerCase()
      return citation.indexOf(query) > -1
    },

    query: debounce(function(e) {
      // search for book if not empty
      const search = this.search
      if (!search) {
        this.books = []
        this.suggest()
        return
      }
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.books = res.data.books
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggest() {
      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        this.loading = false
        return
      }
      this.loading = true
      this.$http.post(this.suggestUrl, qs.stringify({
        courseId: this.syllabus.course_id,
        limit: this.limit
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.books = res.data.books
      }).catch((e) => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
