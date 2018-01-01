<template>
<div v-if="syllabus">

  <h4>References</h4>
  <div>
    <label for="bookPicker">Book/Tag</label>
    <input type="text" id="bookPicker" @input="bookPicker" @focus="bookPicker">
    <button v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button v-else @click="suggest()">Show Suggestions</button>
    <button v-if="res.length" @click="res = []">Hide Selection</button>
  </div>

  <div v-if="selected.length">
    <div><strong>Selected</strong></div>
    <ul>
      <li :key="bfr.id" v-for="(bfr, index) in selected">
        <div>{{ bfr.b_citation }}</div>
        <div>
          <span>Tags:</span>
          <span :key="field.id" v-if="bfr.fields.length"
            v-for="(field, fIndex) in bfr.fields">{{ fIndex === 0 ? '': ', ' }}{{ field.title }}</span>
        </div>
        <button @click="selected.splice(index, 1)">Remove</button>
      </li>
    </ul>
  </div>

  <div v-if="suggested.length" style="max-height: 200px; overflow-y: scroll">
    <h4>Suggested</h4>
    <ul>
      <li :key="bfr.id" v-for="(bfr, index) in suggested">
        <input type="checkbox" :id="'bfr-suggested-' + index" :value="bfr" v-model="selected">
        <label :for="'bfr-suggested-' + index">
          <div>{{ bfr.b_citation }}</div>
          <div>
            <span>Tags:</span>
            <span :key="field.id" v-if="bfr.fields.length"
              v-for="(field, fIndex) in bfr.fields">{{ fIndex === 0 ? '': ', ' }}{{ field.title }}</span>
          </div>
        </label>
      </li>
    </ul>
  </div>
  
  <div v-if="res.length" style="max-height: 200px; overflow-y: scroll">
    <h4>Selection</h4>
    <ul>
      <li :key="bfr.id" v-for="(bfr, index) in res">
        <input type="checkbox" :id="'bfr-' + index" :value="bfr" v-model="selected">
        <label :for="'bfr-' + index">
          <div>{{ bfr.b_citation }}</div>
          <div>
            <span>Tags:</span>
            <span :key="field.id" v-if="bfr.fields.length"
              v-for="(field, fIndex) in bfr.fields">{{ fIndex === 0 ? '': ', ' }}{{ field.title }}</span>
          </div>
        </label>
      </li>
    </ul>
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
      if (to !== null && to !== from) {
        this.suggest()
      }
    }
  },
 
  methods: {
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
        let fields = res.data.fields
        this.res = res.data.books
        this._setFields(this.res, fields)
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    suggest() {
      this.$http.post(this.suggestUrl, qs.stringify({
        courseId: this.syllabus.course_id
      })).then((res) => {
        console.log(res.data)
        let fields = res.data.fields
        this.suggested = res.data.books
        this._setFields(this.suggested, fields)
      }).catch((e) => {
        console.error(e)
      })
    },

    _setFields(books, fields) {
      books.forEach(e => {
        let bookFields = fields.filter(field => {
          return e.b_id == field.b_id
        })
        e.fields = bookFields
        // remove fields
        // assert that removed fields are in bookFields
        fields = fields.slice(bookFields.length)
      })
    }
  }
}
</script>
