<template>
<td>

  <div>
    <label :for="'tla-' + index + '-' + type">Search</label>
    <input type="text" :id="'tla-' + index + '-' + type" @input="tlaSearch" @focus="tlaSearch">
    <button type="button" v-if="!suggested.length" @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="tla.length" @click="tla = []">Hide Selection</button>
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

  <div v-if="tla.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="tla = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in tla">
          <input type="checkbox" :id="'tla-' + index + '-' + type + '-' + i" :value="t" v-model="selected">
          <label :for="'tla-' + index + '-' + type + '-' + i">{{ t }}</label>
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
          <input type="checkbox" :id="'tla-suggested-' + index + '-' + type + '-' + i" :value="t" v-model="selected">
          <label :for="'tla-suggested-' + index + '-' + type + '-' + i">{{ t }}</label>
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
  name: 'tla',
  props: {
    act: Object,
    syllabus: Object,
    index: Number,
    type: Number
  },
  data: () => ({
    url: '/outcomes',
    suggestUrl: '/outcomes/suggest',
    tla: [],
    selected: [],
    suggested: []
  }),

  watch: {
    selected(to, from) {
      if (this.type === 3) {
        this.act.tlaFaculty = to
      } else if (this.type === 4) {
        this.act.tlaStudent = to
      }
    }
  },

  created() {
    this.$bus.$on('gen--topics.updated', this.suggest)
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)
    this.suggest()
  },

  methods: {
    tlaSearch: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.tla = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search,
        type: this.type
      })).then((res) => {
        this.tla = res.data.outcomes
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    suggest() {
      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        return
      }
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

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        topicIds: topicIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        type: this.type,
        limit: 30
      })).then((res) => {
        this.suggested = res.data.outcomes
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>