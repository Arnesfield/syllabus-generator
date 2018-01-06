<template>
<div v-if="syllabus && syllabus.content.programOutcomes.length">

  <h4>{{ mainTitle }}</h4>
  <div>
    <label :for="'outcomeTable-' + abbr">Search/Enter Outcome</label>
    <textarea cols="20" rows="3" :id="'outcomeTable-' + abbr"
      @input="query" @focus="query"></textarea>
    <button type="button" v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button type="button" v-else @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="outcomes.length" @click="outcomes = []">Hide Selection</button>
  </div>

  <div v-if="suggested.length">
    <br>
    <div><strong>Suggested</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="clo.id" v-for="(clo, index) in suggested">
          <input type="checkbox" :id="abbr + '-suggested-' + index" :value="clo" v-model="selected">
          <label :for="abbr + '-suggested-' + index">{{ clo.content }}</label>
        </li>
      </ul>
    </div>
  </div>

  <div v-if="outcomes.length">
    <br>
    <div><strong>Selection</strong></div>
    <div class="selection-box">
      <ul>
        <li :key="o.id" v-for="(o, index) in outcomes">
          <input type="checkbox" :id="'outcome-' + index" :value="o" v-model="selected">
          <label :for="'outcome-' + index">{{ o.content }}</label>
        </li>
      </ul>
    </div>
  </div>

  <br>

  <table class="w-max" border="1">
    <tr>
      <th>&nbsp;</th>
      <th style="width: 50%">{{ mainTitle }}</th>
      <th :colspan="supporting.length">{{ supportingTitle }}</th>
    </tr>
    <tr>
      <td>
        <button type="button" @click="add(0)">+</button>
      </td>
      <td>&nbsp;</td>
      <td style="text-align: center"
        v-for="(po, index) in supporting"
        :key="po.id">{{ typeof po.label !== 'undefined' ? po.label : (index + 1) }}</td>
    </tr>
    <tr :key="clo.id" v-for="(clo, cloIndex) in selected">
      <td>
        <button type="button" @click="remove(cloIndex)">x</button>
        <button type="button" @click="add(cloIndex + 1)">+</button>
      </td>
      <td :ref="'content-' + clo.id">
        <span>{{ (cloIndex + 1) + '. ' }}</span>
        <textarea v-if="typeof clo.id === 'undefined'" class="textarea" v-model="clo.content"></textarea>
        <template v-else>{{ clo.content }}</template>
      </td>
      <td
        @mouseover="over(clo.id, po.id)"
        @mouseout="out(clo.id, po.id)"
        @click="click(cloIndex, po.id)"
        :ref="'box-' + clo.id + '-' + po.id"
        :key="po.id"
        v-for="po in supporting"
        style="text-align: center">
        <template v-if="syllabus.content[mapName][clo.id] === po.id">x</template>
        <template v-else>&nbsp;</template>
      </td>
    </tr>
  </table>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import find from 'lodash/find'

export default {
  name: 'outcome-table',
  props: {
    syllabus: Object,
    supporting: Object,
    mainFieldName: String,
    supportingFieldName: String,
    mainTitle: String,
    supportingTitle: String,
    abbr: String,
    mapName: String
  },
  data: () => ({
    url: '/outcomes',
    suggestUrl: '/outcomes/suggest',
    outcomes: [],
    selected: [],
    suggested: []
  }),

  watch: {
    syllabus(to, from) {
      if (to !== null) {
        // set selected
        this.clear()
        this.selected = this.syllabus.content[this.mainFieldName]
        this.suggest()
      }
    },

    selected(to, from) {
      // set to syllabus once changed
      this.syllabus.content[this.mainFieldName] = to
    }
  },

  created() {
    if (this.syllabus !== null) {
      // set selected
      this.selected = this.syllabus.content[this.mainFieldName]
      this.suggest()
    }
  },

  methods: {
    clear() {
      this.outcomes = []
      this.suggested = []
    },

    over(clo, po) {

    },
    out(clo, po) {

    },
    click(cloIndex, po) {

    },
    add(i) {

    },
    remove(i) {

    },

    query: debounce(function(e) {
      // search for book if not empty
      const search = e.target.value
      if (!search) {
        this.outcomes = []
        return
      }

      this.$http.post(this.url, qs.stringify({
        search: search,
        type: this.abbr === 'clo' ? 1 : 2
      })).then((res) => {
        this.outcomes = res.data.outcomes
      }).catch(e => {
        console.error(e)
      })
    }, 300),

    suggest() {
      // include book ids
      let bookIds = []
      if (typeof this.syllabus.content.bookReferences !== 'undefined') {
        this.syllabus.content.bookReferences.forEach(e => {
          bookIds.push(e.b_id)
        })
      }

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        type: this.abbr === 'clo' ? 1 : 2,
        limit: 10
      })).then((res) => {
        console.log(res.data)
        this.suggested = res.data.outcomes
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
