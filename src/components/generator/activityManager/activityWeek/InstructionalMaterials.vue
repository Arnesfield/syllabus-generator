<template>
<td>
  
  <div>
    <label :for="'search-materials-' + index">Search</label>
    <input type="text" :id="'search-materials-' + index" @input="materialSearch" @focus="materialSearch">
    <button type="button" v-if="!suggested.length" @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="materials.length" @click="materials = []">Hide Selection</button>
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

  <div v-if="materials.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="materials = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in materials">
          <input type="checkbox" :id="'materials-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'materials-' + index + '-' + i">{{ t.name }}</label>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="suggested.length">
    <br>
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="i" v-for="(t, i) in suggested">
          <input type="checkbox" :id="'materials-suggested-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'materials-suggested-' + index + '-' + i">{{ t.name }}</label>
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
  name: 'instructional-materials',
  props: {
    act: Object,
    syllabus: Object,
    index: Number,
    bus: Object
  },
  data: () => ({
    url: '/materials',
    suggestUrl: '/materials/suggest',
    materials: [],
    selected: [],
    suggested: []
  }),

  watch: {
    selected(to, from) {
      this.act.instructionalMaterials = to
    }
  },

  created() {
    this.suggest()
    if (this.bus !== null) {
      this.bus.$on('on-topics-updated', this.suggest)
    }
  },

  methods: {
    materialSearch: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.materials = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.materials = res.data.materials
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

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        topicIds: topicIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        limit: 30
      })).then((res) => {
        this.suggested = res.data.materials
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
