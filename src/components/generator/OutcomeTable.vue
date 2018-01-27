<template>
<div v-if="syllabus && syllabus.content.programOutcomes.length">

  <h4 class="headline mb-2">{{ mainTitle }}</h4>

  <div v-if="suggested.length">
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="clo.id" v-for="(clo, index) in suggested">
          <input type="checkbox" :id="abbr + '-suggested-' + index" :value="clo" v-model="selected">
          <label :for="abbr + '-suggested-' + index">{{ clo }}</label>
        </li>
      </ul>
    </div>
  </div>
  <div v-else>
    <strong>Suggested</strong>. No suggestions to show.
    <button type="button" @click="suggest()">Show</button>
  </div>

  <br>

  <div class="scrollable-x">
    <table class="syllabus-tbl" border="1">
      <tr>
        <th style="width: 1px">&nbsp;</th>
        <th colspan="2" style="width: 50%">{{ mainTitle }}</th>
        <th :colspan="supporting.length">{{ supportingTitle }}</th>
      </tr>
      <tr>
        <td>
          <button type="button" @click="add(0)">+</button>
        </td>
        <td colspan="2">&nbsp;</td>
        <template v-if="supporting.length">
          <td class="t-center"
            v-for="(po, index) in supporting"
            :key="po.id">{{ typeof po.label !== 'undefined' ? po.label : (index + 1) }}</td>
        </template>
        <td v-else>&nbsp;</td>
      </tr>
      <tr :key="cloIndex" v-for="(clo, cloIndex) in syllabus.content[mainFieldName]">
        <td>
          <button type="button" @click="remove(cloIndex)">x</button>
          <button type="button" @click="add(cloIndex + 1)">+</button>
        </td>
        <td style="width: 0">{{ (cloIndex + 1) }}.</td>
        <td style="padding: 0">
          <v-select
            label="Enter clo label"
            :items="searches[cloIndex]"
            :search-input.sync="searchInput[cloIndex]"
            @update:searchInput="doSearch(cloIndex)"
            v-model="selected[cloIndex]"
            flat
            solo
            dense
            combobox
            hide-selected
            debounce-search
            autocomplete>
          </v-select>
        </td>
        <template v-if="supporting.length">
          <td
            class="t-center"
            @mouseover="over(cloIndex, poIndex, $event)"
            @mouseout="out(cloIndex, poIndex, $event)"
            @click="click(cloIndex, abbr === 'clo' ? po.id : poIndex)"
            v-for="(po, poIndex) in supporting"
            :key="poIndex">
            <template v-if="
              typeof syllabus.content[mapName][cloIndex] !== 'undefined' &&
              syllabus.content[mapName][cloIndex].indexOf(
                abbr === 'clo' ? po.id : poIndex
              ) > -1
            ">x</template>
            <template v-else>&nbsp;</template>
          </td>
        </template>
        <td v-else>&nbsp;</td>
      </tr>
    </table>
  </div>

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
import moveArray from '@/assets/js/moveArray'

export default {
  name: 'outcome-table',
  props: {
    syllabus: Object,
    supporting: Array,
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
    highlighted: '',
    // for vselect
    searches: [],
    searchInput: []
  }),

  watch: {
    syllabus(to, from) {
      this.clear()
      if (to !== null) {
        this.doInitial()
      }
    },

    selected(to, from) {
      // set to syllabus once changed
      this.syllabus.content[this.mainFieldName] = to
    },

    searchInput: {
      deep: true,
      handler: function(to, from) {

      }
    }
  },

  created() {
    if (this.syllabus !== null) {
      this.doInitial()
    }
  },

  methods: {
    doInitial() {
      // set selected
      this.syllabus.content[this.mainFieldName].forEach((e, i) => {
        // make selected only string
        this.$set(this.selected, i, typeof e === 'string' ? e : e.content)
      })
      this.suggest()
    },

    doSearch(i) {
      // do search only if search input contains value
      if (!this.searchInput[i]) {
        return
      }

      // search
      this.$http.post(this.url, qs.stringify({
        search: this.searchInput[i],
        type: this.abbr === 'clo' ? 1 : 2
      })).then((res) => {
        if (typeof res.data.outcomes !== 'object') {
          return
        }
        this.$set(this.searches, i, res.data.outcomes)
      }).catch(e => {
        console.error(e)
      })
    },

    clear() {
      this.outcomes = []
      this.suggested = []
    },

    over(clo, po, e) {
      e.target.classList.add('outcome-highlighted')
      let o = this.syllabus.content[this.supportingFieldName][po]
      this.highlighted = (typeof o.label !== 'undefined' ? o.label + '. ' : '') + o.content
    },
    out(clo, po, e) {
      e.target.classList.remove('outcome-highlighted')
      this.highlighted = ''
    },
    click(clo, po) {
      // check in map if exists
      // if undefined, add array
      if (typeof this.syllabus.content[this.mapName][clo] === 'undefined') {
        this.$set(this.syllabus.content[this.mapName], clo, [])
      }

      let set = new Set(this.syllabus.content[this.mapName][clo])
      // if existing, remove it
      set.has(po) ? set.delete(po) : set.add(po)

      this.syllabus.content[this.mapName][clo] = Array.from(set)
    },

    add(i) {
      this.selected.splice(i, 0, null)
      // move up
      this._updateMap(this.syllabus.content[this.mapName], i, 1)
    },
    remove(i) {
      this.selected.splice(i, 1)
      // move down
      this._updateMap(this.syllabus.content[this.mapName], i, -1)
    },

    _updateMap(map, i, n) {
      this.$bus.$emit('clo-updated', i, n)
      this.syllabus.content[this.mapName] = this.moveMap(map, i, n)
    },

    moveMap(map, i, n) {
      let newMap = {}
      Object.keys(map).forEach(e => {
        // if is equal to i or more
        // add n
        let m = Number(e)
        // check if n is -1
        // if -1 and m == i, do not include
        if (m >= i) {
          if (!(n === -1 && m === i)) {
            newMap[m + n] = map[e]
          }
        } else {
          // else, retain it and add it to new map
          newMap[e] = map[e]
        }
      })
      return newMap
    },

    moveArray(map, i, n) {
      Object.keys(map).forEach(e => {
        map[e] = moveArray(map[e], i, n)
      })
      return map
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
        limit: 30
      })).then((res) => {
        this.suggested = res.data.outcomes
      }).catch((e) => {
        console.error(e)
      })
    }
  }
}
</script>
