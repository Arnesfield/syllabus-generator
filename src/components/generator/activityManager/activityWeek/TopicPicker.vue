<template>
<td>

  <div>
    <label for="topicPicker">Search Topics</label>
    <input type="text" id="topicPicker" @input="topicPicker" @focus="topicPicker">
    <button type="button" v-if="!suggested.length" @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="topics.length" @click="topics = []">Hide Selection</button>
  </div>

  <div v-if="selected.length">
    <br>
    <div><strong>Selected</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="index" v-for="(t, index) in selected">
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
        <li :key="i" v-for="(t, i) in topics">
          <input type="checkbox" :id="'topic-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'topic-' + index + '-' + i">
            <topic :topic="t"/>
          </label>
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
          <input type="checkbox" :id="'topic-suggested-' + index + '-' + i" :value="t" v-model="selected">
          <label :for="'topic-suggested-' + index + '-' + i">
            <topic :topic="t"/>
          </label>
        </li>
      </ul>
    </div>
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
    index: Number
  },
  data: () => ({
    url: '/topics',
    suggestUrl: '/topics/suggest',
    topics: [],
    selected: [],
    suggested: []
  }),

  watch: {
    selected(to, from) {
      // set to topics in syllabus
      this.act.topics = to
      // update outcomes on tla
      this.$bus.$emit('on-topics-updated')
    }
  },

  created() {
    this.suggest()
    this.$bus.$on('update-suggestions', this.suggest)
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

      // include clo content
      let cloContent = ''
      this.act.cloMap.forEach(e => {
        let clo = this.syllabus.content.courseLearningOutcomes[e]
        if (typeof clo.content !== 'undefined') {
          cloContent += ' ' + clo.content
        }
      })

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        cloContent: cloContent,
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
