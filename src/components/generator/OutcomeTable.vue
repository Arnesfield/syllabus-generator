<template>
<div v-if="syllabus && syllabus.content.programOutcomes.length">

  <h4>{{ mainTitle }}</h4>
  <div>
    <label :for="'outcomeTable-' + abbr">Search/Enter Outcome</label>
    <textarea
      :id="'outcomeTable-' + abbr"
      rows="3"
      cols="20"
      @input="query"
      @focus="query"></textarea>
    <button type="button" v-if="suggested.length" @click="suggested = []">Hide Suggestions</button>
    <button type="button" v-else @click="suggest()">Show Suggestions</button>
    <button type="button" v-if="outcomes.length" @click="outcomes = []">Hide Selection</button>
  </div>

  <div v-if="suggested.length">
    <br>
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
    </div>
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
    <tr :key="clo.id" v-for="(clo, cloIndex) in syllabus.content[mainFieldName]">
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
        @mouseover="over(cloIndex, poIndex, $event)"
        @mouseout="out(cloIndex, poIndex, $event)"
        @click="click(cloIndex, po.id)"
        :ref="'box-' + cloIndex + '-' + po.id"
        :key="po.id"
        v-for="(po, poIndex) in supporting"
        style="text-align: center">
        <template v-if="
          typeof syllabus.content[mapName][cloIndex] !== 'undefined' &&
          syllabus.content[mapName][cloIndex].indexOf(po.id) > -1
        ">x</template>
        <template v-else>&nbsp;</template>
      </td>
    </tr>
  </table>

  <template v-if="highlighted.length">
    <br>
    <div>
      <strong>Highlighted:</strong> {{ highlighted }}
    </div>
  </template>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

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
    suggested: [],
    highlighted: ''
  }),

  watch: {
    syllabus(to, from) {
      this.clear()
      if (to !== null) {
        // set selected
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

    over(clo, po, e) {
      e.target.classList.add('outcome-selected')
      let o = this.syllabus.content[this.supportingFieldName][po]
      this.highlighted = o.label + '. ' + o.content
    },
    out(clo, po, e) {
      e.target.classList.remove('outcome-selected')
      this.highlighted = ''
    },
    click(clo, po) {
      // check in map if exists
      // if undefined, add array
      if (typeof this.syllabus.content[this.mapName][clo] === 'undefined') {
        this.$set(this.syllabus.content[this.mapName], clo, [])
      }

      let map = this.syllabus.content[this.mapName][clo]

      // if existing, remove it
      if (map.indexOf(po) > -1) {
        var set = new Set(map)
        set.delete(po)
      } else {
        map.push(po)
        var set = new Set(map)
      }

      this.syllabus.content[this.mapName][clo] = Array.from(set)
    },

    add(i) {
      this.selected.splice(i, 0, { content: '' })
    },
    remove(i) {
      this.selected.splice(i, 1)
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
          bookIds.push(e.id)
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
