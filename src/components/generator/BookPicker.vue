<template>
<div v-if="syllabus">

  <div>
    <!-- <label for="bookPicker">Book/Tag</label>
    <input type="text" id="bookPicker" @input="search" @focus="search"> -->
    <!-- <button type="button" v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button type="button" v-else @click="suggest()">Show Suggestions</button> -->
    <!-- <button type="button" v-if="books.length" @click="books = []">Hide Selection</button> -->
<!-- 
    <v-select
      label="Select Books"
      :items="books"
      :loading="loading"
      :searchInput.sync="searchInput"
      :filter="filterSearch"
      item-text="citation"
      item-value="id"
      v-model="selected"
      chips
      multiple
      autocomplete
      return-object
      debouce-search>
      <template slot="selection" slot-scope="data"></template>
    </v-select> -->
  </div>

  <div>
    <v-list class="elevation-2">
      <v-list-tile>
        <v-list-tile-content>
          <v-list-tile-title v-text="'Selected books'"/>
          <v-list-tile-sub-title v-text="'Total books selected: ' + selected.length"/>
        </v-list-tile-content>
      </v-list-tile>
      <template v-for="(book, i) in selected">
        <v-divider :key="JSON.stringify(book)"/>
        <v-list-tile :key="JSON.stringify(book)">
          <v-list-tile-action>
            <v-btn flat icon @click="selected.splice(i, 1)">
              <v-icon>close</v-icon>
            </v-btn>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title v-text="book.citation"/>
          </v-list-tile-content>
        </v-list-tile>
      </template>
    </v-list>
  </div>

  <v-text-field
    class="mt-2"
    label="Search Books"
    prepend-icon="search"
    :loading="loading"
    solo
    clearable
    single-line
    @input="search"/>

  <v-list v-if="books.length" class="mt-2 elevation-2">
    <template v-for="(book, i) in books">
      <v-list-tile :key="JSON.stringify(book)">
        <v-list-tile-content>
          <v-list-tile-title>
            <v-checkbox
              :label="book.citation"
              :value="book"
              v-model="selected"/>
          </v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
      <v-divider v-if="i < books.length-1" :key="JSON.stringify(book)"/>
    </template>
  </v-list>

  <suggest-alert v-if="!$bus.generator.suggestions"/>
  <div class="mt-2" v-else>
    <v-list class="elevation-2">
      <v-list-tile>
        <v-list-tile-action>
          <v-btn flat icon @click="suggest">
            <v-icon>refresh</v-icon>
          </v-btn>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title v-text="'Suggested books'"/>
        </v-list-tile-content>
      </v-list-tile>
      <template
        v-for="(book, i) in suggested"
        v-if="suggested.filter(s => (s.id == book.id)).length">
        <v-divider :key="'divider-' + i"/>
        <v-list-tile :key="'tile-' + i">
          <v-list-tile-content>
            <v-list-tile-title>
            <v-checkbox
              :label="book.citation"
              :value="book"
              v-model="selected"/>
            </v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>
    </v-list>
  </div>
  
  <!-- <div v-if="books.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="books = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="bfr.id" v-for="(bfr, index) in books">
          <input type="checkbox" :id="'bfr-' + index" :value="bfr" v-model="selected">
          <label :for="'bfr-' + index">{{ bfr.citation }}</label>
        </li>
      </ul>
    </div>
  </div> -->

  <!-- <br>
  
  <div v-if="suggested.length">
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="bfr.id" v-for="(bfr, index) in suggested">
          <input type="checkbox" :id="'bfr-suggested-' + index" :value="bfr" v-model="selected">
          <label :for="'bfr-suggested-' + index">{{ bfr.citation }}</label>
        </li>
      </ul>
    </div>
  </div>
  <div v-else>
    <strong>Suggested</strong>. No suggestions to show.
    <button type="button" @click="suggest()">Show</button>
  </div> -->
  
</div>
</template>

<script>
import qs from 'qs'
import SuggestAlert from '@/include/generator/SuggestAlert'

export default {
  name: 'book-picker',
  components: {
    SuggestAlert
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    url: '/books',
    suggestUrl: '/books/suggest',
    books: [],
    suggested: [],
    selected: [],
    // for select box
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
    }
  },

  created() {
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)
    if (this.syllabus !== null) {
      // set selected as book content from syllabus
      this.selected = this.syllabus.content.bookReferences
      this.suggest()
    }
  },
 
  methods: {
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

    search(search) {
      // search for book if not empty
      if (search === null || !search.length) {
        this.books = []
        this.loading = false
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
    },

    suggest() {
      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        return
      }
      this.$http.post(this.suggestUrl, qs.stringify({
        courseId: this.syllabus.course_id,
        limit: 30
      })).then((res) => {
        this.suggested = res.data.books
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
