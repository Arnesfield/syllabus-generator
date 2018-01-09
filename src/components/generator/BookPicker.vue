<template>
<div v-if="syllabus">

  <h4>References</h4>
  <div>
    <label for="bookPicker">Book/Tag</label>
    <input type="text" id="bookPicker" @input="bookPicker" @focus="bookPicker">
    <button type="button" v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button type="button" v-else @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="res.length" @click="res = []">Hide Selection</button>
  </div>

  <div v-if="selected.length">
    <br>
    <div><strong>Selected</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="bfr.id" v-for="(bfr, index) in selected">
          <button type="button" @click="selected.splice(index, 1)">x</button>
          <span>{{ bfr.citation }}</span>
        </li>
      </ul>
    </div>
  </div>

  <br>
  
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
  </div>
  
  <div v-if="res.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="res = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="bfr.id" v-for="(bfr, index) in res">
          <input type="checkbox" :id="'bfr-' + index" :value="bfr" v-model="selected">
          <label :for="'bfr-' + index">{{ bfr.citation }}</label>
        </li>
      </ul>
    </div>
  </div>
  
</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'book-picker',
  props: {
    syllabus: Object
  },
  data: () => ({
    url: '/books',
    suggestUrl: '/books/suggest',
    res: [],
    suggested: [],
    selected: []
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
    if (this.syllabus !== null) {
      // set selected as book content from syllabus
      this.selected = this.syllabus.content.bookReferences
      this.suggest()
    }
  },
 
  methods: {
    clear() {
      this.res = []
      this.suggested = []
      this.selected = []
    },

    bookPicker: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.res = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.res = res.data.books
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    suggest() {
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
