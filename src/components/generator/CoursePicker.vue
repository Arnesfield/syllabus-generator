<template>
<div>
  <v-select
    label="Select Course"
    :items="courses"
    :loading="loading"
    :searchInput.sync="searchInput"
    :filter="filterSearch"
    :hint="selected ? selected.title : ''"
    prepend-icon="search"
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

  <template v-if="selected">
    <div class="scrollable-x mt-3">
      <table class="syllabus-tbl" border="1">
        <tr>
          <th>Course Code</th>
          <th>Course Title</th>
          <th>Units/Type</th>
        </tr>
        <tr>
          <td>{{ selected.code }}</td>
          <td>{{ selected.title }}</td>
          <td>
            <template v-if="Number(selected.unitsLec)"
              >{{ selected.unitsLec }} {{ selected.unitsLec == 1 ? 'Unit' : 'Units' }} LEC
            </template>
            <template v-if="Number(selected.unitsLec) && Number(selected.unitsLab)">/</template>
            <template v-if="Number(selected.unitsLab)"
              >{{ selected.unitsLab }} {{ selected.unitsLab == 1 ? 'Unit' : 'Units' }} LAB
            </template>
          </td>
        </tr>

        <tr>
          <th>&nbsp;</th>
          <th>Course Code</th>
          <th>Course Title</th>
        </tr>

        <template v-if="selected.prerequisites">
          <tr
            :key="i"
            v-for="(c, i) in selected.prerequisites">
            <td>
              <template v-if="i === 0"><strong>Prerequisites</strong></template>
              <template v-else>&nbsp;</template>
            </td>
            <td>{{ c.code }}</td>
            <td>{{ c.title }}</td>
          </tr>
        </template>
        <tr v-else>
          <td><strong>Prerequisites</strong></td>
          <td colspan="2">None</td>
        </tr>

        <template v-if="selected.corequisites">
          <tr
            :key="i"
            v-for="(c, i) in selected.corequisites">
            <td>
              <template v-if="i === 0"><strong>Corequisites</strong></template>
              <template v-else>&nbsp;</template>
            </td>
            <td>{{ c.code }}</td>
            <td>{{ c.title }}</td>
          </tr>
        </template>
        <tr v-else>
          <td><strong>Corequisites</strong></td>
          <td colspan="2">None</td>
        </tr>

        <tr>
          <td><strong>Course Description</strong></td>
          <td colspan="2" v-html="selected.description"></td>
        </tr>

        <tr>
          <td><strong>Course Objectives</strong></td>
          <td colspan="2" v-html="selected.objectives"></td>
        </tr>
      </table>
    </div>

    <v-btn
      class="mt-3"
      color="primary"
      @click="$bus.tabs.Generator.tab = '1'">Next</v-btn>

  </template>
</div>
</template>

<script>
import qs from 'qs'

export default {
  name: 'course-picker',
  data: () => ({
    url: '/courses',
    relatedUrl: '/courses/related',
    courses: [],
    selected: null,
    // for select box
    searchInput: null,
    loading: false
  }),

  watch: {
    selected(to, from) {
      this.getRelated()
      this.$emit('course-selected', to)
    },
    searchInput(e) {
      this.search(e ? e : '')
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
    },

    getRelated() {
      this.loading = true
      this.$http.post(this.relatedUrl, qs.stringify({
        id: this.selected.id
      })).then((res) => {
        this.$set(this.selected, 'prerequisites', res.data.prerequisites)
        this.$set(this.selected, 'corequisites', res.data.corequisites)
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
