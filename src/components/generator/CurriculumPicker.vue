<template>
<div v-if="syllabus">
  <div>
    <label for="curriculumQuery">Curriculum</label>
    <input type="text" id="curriculumQuery"
      v-model="searchYear" @input="yearQuery" @focus="yearQuery">
    <button v-if="years.length" @click="years = []">Hide Selection</button>
  </div>

  <div v-if="years.length">
    <h4>Selection</h4>

    <div style="max-height: 200px; overflow-y: scroll">
      <ul>
        <li :key="year" v-for="(year, index) in years">
          <input type="radio" :id="'year-' + index" :value="year" v-model="selected">
          <label :for="'year-' + index">{{ year.year }}</label>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="curriculum.length">
    <h4>Curriculum</h4>
    <div :key="c.id" v-for="c in curriculum">{{ c.label + '. ' + c.content }}</div>
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
    curriculumUrl: '/curriculum',
    searchYear: new Date().getFullYear(),
    years: [],
    curriculum: [],
    selected: null
  }),

  watch: {
    selected(to, from) {
      if (to !== null) {
        this.curriculumQuery(to.year)
      } else {
        this.curriculum = []
      }
    }
  },

  methods: {
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
