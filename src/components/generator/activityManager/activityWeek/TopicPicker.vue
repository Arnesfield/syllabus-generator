<template>
<td>

  <div>
    <label for="topicPicker">Search Topics</label>
    <input type="text" id="topicPicker" @input="topicPicker" @focus="topicPicker">
    <button type="button" v-if="topics.length" @click="topics = []">Hide Selection</button>
  </div>

  <div v-if="selected.length">
    <div><strong>Selected</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="t.id" v-for="(t, index) in selected">
          <button type="button" @click="selected.splice(index, 1)">x</button>
          <topic :topic="t"/>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="topics.length">
    <br>
    <div>
      <strong>Selection</strong>
      <button type="button" @click="topics = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="t.id" v-for="t in topics">
          <input type="checkbox" :id="'topic-' + t.id" :value="t" v-model="selected">
          <label :for="'topic-' + t.id">
            <topic :topic="t"/>
          </label>
        </li>
      </ul>
    </div>
  </div>

  <br>
  
  <div v-if="suggested.length">
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="t.id" v-for="t in suggested">
          <input type="checkbox" :id="'topic-suggested-' + t.id" :value="t" v-model="selected">
          <label :for="'topic-suggested-' + t.id">
            <topic :topic="t"/>
          </label>
        </li>
      </ul>
    </div>
  </div>
  <div v-else>
    <strong>Suggested</strong>. No suggestions to show.
    <button type="button" @click="suggest()">Show</button>
  </div>

</td>  
</template>

<script>
import Topic from './topicPicker/Topic'
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'topic-picker',
  components: {
    Topic
  },
  props: {
    act: Object,
    syllabus: Object,
    bus: {
      type: Object,
      default: null
    }
  },
  data: () => ({
    url: '/topics',
    suggestUrl: '/topics/suggest',
    topics: [],
    selected: [],
    suggested: []
  }),

  created() {
    this.suggest()
    if (this.bus !== null) {
      this.bus.$on('update-suggestions', this.suggest)
    }
  },

  methods: {
    topicPicker: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.topics = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        this.topics = res.data.topics
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

      // include ilo ids
      let iloIds = []
      this.act.iloMap.forEach(e => {
        let ilo = this.syllabus.content.intendedLearningOutcomes[e]
        if (typeof ilo.id !== 'undefined') {
          iloIds.push(ilo.id)
        }
      })

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        iloIds: iloIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        limit: 30
      })).then((res) => {
        this.suggested = res.data.topics
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
