<template>
<div>
  <div>
    <label for="coursePicker">Course</label>
    <input type="text" id="coursePicker" @input="coursePicker" @focus="coursePicker">
    <button type="button" v-if="res.length" @click="res = []">Hide Selection</button>
  </div>

  <div v-if="selected">
    <br>
    <div><strong>Selected</strong></div>
    <ul>
      <li>
        <div>{{ selected.code }}</div>
        <div>{{ selected.title }}</div>
      </li>
    </ul>
  </div>

  <div v-if="res.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="res = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="course.id" v-for="(course, index) in res">
          <input type="radio" :id="'course-' + index" :value="course" v-model="selected">
          <label :for="'course-' + index">
            <div>{{ course.code }}</div>
            <div>{{ course.title }}</div>
          </label>
        </li>
      </ul>
    </div>
  </div>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'course-picker',
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
    coursePicker: debounce(function(e) {
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
