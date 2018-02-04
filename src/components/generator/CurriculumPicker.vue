<template>
<div v-if="syllabus">
  <div>
    <label for="curriculumQuery">Curriculum</label>
    <input type="text" id="curriculumQuery"
      v-model="searchYear" @input="yearQuery" @focus="yearQuery">
    <button type="button" v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button type="button" v-else @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="years.length" @click="years = []">Hide Selection</button>
  </div>

  <suggest-alert v-if="!$bus.generator.suggestions"/>
  <div v-else-if="suggested.length">
    <span>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </span>

    <span :key="index" v-for="(year, index) in suggested">
      <input type="radio" :id="'year-suggested-' + index" :value="year" v-model="selected">
      <label :for="'year-suggested-' + index">{{ year.year }}</label>
    </span>
  </div>
  <div v-else>
    <strong>Suggested</strong>. No suggestions to show.
    <button type="button" @click="suggest()">Show</button>
  </div>

  <div v-if="years.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="years = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="index" v-for="(year, index) in years">
          <input type="radio" :id="'year-' + index" :value="year" v-model="selected">
          <label :for="'year-' + index">{{ year.year }}</label>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="curriculum.length">
    <h4>Program Outcomes</h4>
    <div
      :key="c.id"
      :ref="'po-' + c.id"
      v-for="c in curriculum">{{ c.label + '. ' + c.content }}</div>
  </div>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SuggestAlert from '@/include/generator/SuggestAlert'

export default {
  name: 'curriculum-picker',
  components: {
    SuggestAlert
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    yearUrl: '/curriculum/years',
    suggestUrl: '/curriculum/years/suggest',
    curriculumUrl: '/curriculum',
    searchYear: '',
    years: [],
    curriculum: [],
    suggested: [],
    selected: null
  }),

  watch: {
    syllabus(to, from) {
      // if null, just clear
      // clear values and suggest when syllabus is changed
      this.clear()
      if (to !== null) {
        if (!this.setFromSyllabus()) {
          this.suggest()
        }
      }
    },

    selected(to, from) {
      if (to !== null) {
        // hide suggestions if selected is the same as suggested
        if (this.suggested.length && to.year === this.suggested[0].year) {
          this.suggested = []
        } else {
          // show suggestions
          this.suggest(to.year)
        }
        this.curriculumQuery(to.year)
      } else {
        this.curriculum = []
      }
    },

    curriculum(to, from) {
      // set changes to programOutcomes
      this.syllabus.content.programOutcomes = to
    }
  },

  created() {
    // do suggest when bus generator suggestions changes
    this.$bus.$on('bus-generator-suggestion-change', this.suggest)
    if (this.syllabus !== null) {
      // removed suggest since setting 'selected' will trigger suggest(n)
      if (!this.setFromSyllabus()) {
        this.suggest()
      }
    }
  },

  methods: {
    clear() {
      this.years = []
      this.curriculum = []
      this.suggested = []
      this.selected = null
    },

    setFromSyllabus() {
      // set syllabus programOutcomes to curriculum
      if (
        typeof this.syllabus.content.programOutcomes === 'undefined' ||
        this.syllabus.content.programOutcomes.length === 0
      ) { return false }
      let po = this.syllabus.content.programOutcomes
      this.selected = { year: po[0].year }
      this.curriculum = po
      return true
    },

    suggest(year) {
      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        return
      }
      this.$http.post(this.suggestUrl).then((res) => {
        let suggested = res.data.years
        let assign = true
        if (typeof year !== 'undefined') {
          // if year is not the same as suggested
          // show suggested
          assign = year !== suggested[0].year
        }

        if (assign) {
          this.suggested = suggested
        }
      }).catch(e => {
        console.error(e)
      })
    },

    yearQuery: debounce(function(e) {
      // search for years if not empty
      const search = e.target.value
      if (!search) {
        this.years = []
        return
      }

      this.$http.post(this.yearUrl, qs.stringify({
        search: search
      })).then((res) => {
        this.years = res.data.years
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    curriculumQuery(year) {
      this.$http.post(this.curriculumUrl, qs.stringify({
        year: year
      })).then((res) => {
        this.curriculum = res.data.curriculum
        // clear out years and set the search to that year
        this.years = []
        this.searchYear = this.selected.year
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
