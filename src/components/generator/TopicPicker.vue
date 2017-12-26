<template>
<div v-if="syllabus">
  <hr>
  <div>
    <label for="topicPicker">Topics</label>
    <input type="text" id="topicPicker" @input="topicPicker" @focus="topicPicker">
    <span v-if="res.length">
      <span @click="res = []">Hide Selection</span>
    </span>
  </div>

  <div v-if="selected.length">
    <div>
      <div><strong>Selected</strong></div>
      <div :key="bfr.id" v-for="bfr in selected">
        <div>{{ bfr.b_citation }}</div>
      </div>
    </div>
  </div>
  
  <div v-if="res.length" style="max-height: 200px; overflow-y: scroll">
    <div :key="bfr.id" v-for="(bfr, index) in res">
      <input type="checkbox" :id="'bfr-' + index" :value="bfr" v-model="selected">
      <label :for="'bfr-' + index">
        <div>{{ bfr.b_citation }}</div>
      </label>
    </div>
  </div>
</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'topic-picker',
  data: () => ({
    syllabus: null,
    url: '/topics',
    res: [],
    selected: []
  }),

  methods: {
    onSyllabusFetched(syllabus) {
      this.syllabus = syllabus
    },

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
        this.res = res.data.topics
      }).catch(e => {
        console.error(e)
      })
    }, 300)
  }
}
</script>
