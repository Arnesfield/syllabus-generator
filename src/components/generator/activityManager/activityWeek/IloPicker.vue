<template>
<td>
  
  <div>
    <label :for="'search-outcomes-' + index">Search</label>
    <input type="text" :id="'search-outcomes-' + index" @input="query" @focus="query">
    <button type="button" v-if="!suggested.length" @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="outcomes.length" @click="outcomes = []">Hide Selection</button>
  </div>

  <div v-if="selected.length">
    <br>
    <div><strong>Selected</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in selected">
          <button type="button" @click="selected.splice(i, 1)">x</button>
          <template>{{ t }}</template>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="outcomes.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="outcomes = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in outcomes">
          <input type="checkbox" :id="'outcomes-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'outcomes-' + index + '-' + i">{{ t }}</label>
        </li>
      </ul>
    </div>
  </div>

  <template v-if="!$bus.generator.suggestions"></template>
  <div v-else-if="suggested.length">
    <br>
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in suggested">
          <input type="checkbox" :id="'outcomes-suggested-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'outcomes-suggested-' + index + '-' + i">{{ t }}</label>
        </li>
      </ul>
    </div>
  </div>

</td>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'ilo-picker',
  props: {
    act: Object,
    syllabus: Object,
    index: Number
  },
  data: () => ({
    url: '/outcomes',
    suggestUrl: '/outcomes/suggest',
    outcomes: [],
    selected: [],
    suggested: []
  }),

  watch: {
    selected(to, from) {
      this.act.ilo = to
    }
  },

  created() {
    this.suggest()
    this.$bus.$on('update-suggestions', this.suggest)
    this.$bus.$on('on-topics-updated', this.suggest)
  },

  methods: {
    query: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.outcomes = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search,
        type: 2
      })).then((res) => {
        this.outcomes = res.data.outcomes
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    suggest() {
      // include book ids
      let bookIds = []
      if (typeof this.syllabus.content.bookReferences !== 'undefined') {
        this.syllabus.content.bookReferences.forEach(e => {
          bookIds.push(e.id)
        })
      }

      // include topic ids
      let topicIds = []
      this.act.topics.forEach(e => {
        if (typeof e.id !== 'undefined') {
          topicIds.push(e.id)
        }
      })

      // include clo content
      let cloContent = ''
      this.act.cloMap.forEach(e => {
        let clo = this.syllabus.content.courseLearningOutcomes[e]
        if (typeof clo !== 'undefined') {
          cloContent += ' ' + clo
        }
      })

      // include number of clos for limit
      let cloLimit = Object.keys(this.act.cloMap).length

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        cloContent: cloContent,
        topicIds: topicIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        type: 2,
        limit: 30,
        cloLimit: cloLimit
      })).then((res) => {
        this.suggested = res.data.outcomes
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
