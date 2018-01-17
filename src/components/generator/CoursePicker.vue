<template>
<div>
  <v-select
    label="Select Course"
    :items="courses"
    :loading="loading"
    :searchInput.sync="searchInput"
    :filter="filterSearch"
    :hint="selected ? selected.title : ''"
    persistent-hint
    item-text="code"
    item-value="id"
    v-model="selected"
    autocomplete
    return-object
    debouce-search>
    <template slot="item" slot-scope="data">
      <v-list-tile-content>
        <v-list-tile-title v-html="data.item.code"/>
        <v-list-tile-sub-title v-html="data.item.title"/>
      </v-list-tile-content>
    </template>
  </v-select>
</div>
</template>

<script>
import qs from 'qs'

export default {
  name: 'course-picker',
  data: () => ({
    url: '/courses',
    courses: [],
    selected: null,
    // for select box
    searchInput: null,
    loading: false
  }),

  watch: {
    selected(to, from) {
      this.$emit('course-selected', to)
    },
    searchInput(e) {
      e && this.search(e)
    }
  },

  methods: {
    filterSearch(item, queryText, itemText) {
      const hasValue = val => val != null ? val : ''
      const title = hasValue(item.title).toString().toLowerCase()
      const code = hasValue(item.code).toString().toLowerCase()
      const query = hasValue(queryText).toString().toLowerCase()
      return title.indexOf(query) > -1 || code.indexOf(query) > -1
    },

    search(search) {
      // search for course if not empty
      // assume that search is not empty
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.courses = typeof res.data.courses === 'object' ? res.data.courses : []
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
