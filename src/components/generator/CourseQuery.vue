<template>
<div>
  <div>
    <label for="courseQuery">Course</label>
    <input type="text" id="courseQuery" @input="courseQuery" @focus="courseQuery">
  </div>

  <div v-if="selected">
    <div>
      <div><strong>Selected</strong></div>
      <div>{{ selected.code }}</div>
      <div>{{ selected.title }}</div>
    </div>
  </div>
  
  <div v-if="res.length" style="max-height: 200px; overflow-y: scroll">
    <div :key="course.id" v-for="(course, index) in res">
      <input type="radio" :id="'course-' + index" :value="course" v-model="selected">
      <label :for="'course-' + index">
        <div>{{ course.code }}</div>
        <div>{{ course.title }}</div>
      </label>
    </div>
  </div>
</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'course-query',
  data: () => ({
    url: '/courses',
    res: [],
    selected: null
  }),

  watch: {
    selected(to, from) {
      if (to !== from) {
        this.res = []
      }
      if (to !== null) {
        this.$emit('course-selected', to)
      }
    }
  },

  methods: {
    courseQuery: debounce(function(e) {
      // search for course if not empty
      const search = e.target.value
      if (!search) {
        this.res = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.res = res.data.courses
      }).catch(e => {
        console.error(e)
      })
    }, 300)
  }
}
</script>
