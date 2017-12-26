<template>
<div v-if="syllabus">
  <hr>

  <h4>References</h4>
  <div>
    <label for="topicPicker">Topic/Book</label>
    <input type="text" id="topicPicker" @input="topicPicker" @focus="topicPicker">
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
  
  <div v-if="res.length" style="max-height: 200px; overflow-y: scroll">
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
  name: 'topic-picker',
  props: {
    syllabus: Object
  },
  data: () => ({
    url: '/topics',
    res: [],
    selected: []
  }),

  methods: {
    topicPicker: debounce(function(e) {
      // search for topic if not empty
      const search = e.target.value
      if (!search) {
        this.res = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        let fields = res.data.fields
        this.res = res.data.topics
        this.res.forEach(e => {
          let bookFields = fields.filter(field => {
            return e.b_id == field.b_id
          })
          e.fields = bookFields
          // remove fields
          // assert that removed fields are in bookFields
          fields = fields.slice(bookFields.length)
        })
      }).catch(e => {
        console.error(e)
      })
    }, 300)
  }
}
</script>
