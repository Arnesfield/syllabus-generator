<template>
<td>
  
  <div>
    <label :for="'search-tasks-' + index">Search</label>
    <input type="text" :id="'search-tasks-' + index" @input="search" @focus="search">
    <button type="button" v-if="!suggested.length" @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="tasks.length" @click="tasks = []">Hide Selection</button>
  </div>

  <div v-if="selected.length">
    <br>
    <div><strong>Selected</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in selected">
          <button type="button" @click="selected.splice(i, 1)">x</button>
          <template>{{ t.name }}</template>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="tasks.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="tasks = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in tasks">
          <input type="checkbox" :id="'tasks-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'tasks-' + index + '-' + i">{{ t.name }}</label>
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
          <input type="checkbox" :id="'tasks-suggested-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'tasks-suggested-' + index + '-' + i">{{ t.name }}</label>
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
  name: 'assessment-tasks',
  props: {
    act: Object,
    syllabus: Object,
    index: Number
  },
  data: () => ({
    url: '/tasks',
    suggestUrl: '/tasks/suggest',
    tasks: [],
    selected: [],
    suggested: []
  }),

  watch: {
    selected(to, from) {
      // set to tasks in syllabus
      this.act.assessmentTasks = to
    }
  },

  created() {
    this.$bus.$on('gen--topics.updated', this.suggest)
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)

    // set tasks
    if (this.act) {
      this.selected = this.act.assessmentTasks
    }

    this.suggest()
  },
  beforeDestroy() {
    this.$bus.$off('gen--topics.updated', this.suggest)
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },

  methods: {
    search: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.tasks = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.tasks = res.data.tasks
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
        limit: 30
      })).then((res) => {
        this.suggested = res.data.tasks
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
