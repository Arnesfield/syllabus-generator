<template>
<div v-if="syllabus">
  <div>
    <label for="curriculumQuery">Curriculum</label>
    <input type="text" id="curriculumQuery"
      v-model="searchYear" @input="yearQuery" @focus="yearQuery">
    <button v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button v-else @click="suggest()">Show Suggestions</button>
    <button v-if="years.length" @click="years = []">Hide Selection</button>
  </div>

  <div v-if="suggested.length">
    <br>
    <span><strong>Suggested</strong></span>

    <span :key="year" v-for="(year, index) in suggested">
      <input type="radio" :id="'year-suggested-' + index" :value="year" v-model="selected">
      <label :for="'year-suggested-' + index">{{ year.year }}</label>
    </span>
  </div>

  <div v-if="years.length">
    <br>
    <div><strong>Selection</strong></div>

    <div class="selection-box">
      <ul>
        <li :key="year" v-for="(year, index) in years">
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

export default {
  name: 'curriculum-picker',
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
        this.suggest()
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
    }
  },

  created() {
    if (this.syllabus !== null) {
      this.suggest()
    }
  },

  methods: {
    clear() {
      this.years = []
      this.curriculum = []
      this.suggested = []
      this.selected = null
    },

    suggest(year) {
      this.$http.post(this.suggestUrl).then((res) => {
        console.log(res.data)
        let suggested = res.data.years
        let assign = true
        if (typeof year === 'number' && suggested.length) {
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
        console.log(res.data)
        this.years = res.data.years
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    curriculumQuery(year) {
      this.$http.post(this.curriculumUrl, qs.stringify({
        year: year
      })).then((res) => {
        console.log(res.data)
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
