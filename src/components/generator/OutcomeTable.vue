<template>
<div v-if="syllabus && c.programOutcomes.length">

  <h4 class="headline mb-2">{{ mainTitle }}</h4>

  <suggest-alert v-if="!$bus.generator.suggestions"/>
  <div v-else-if="suggested.length">
    <div>
      <strong>Suggested</strong>
      <button type="button" @click="suggest()">Refresh</button>
      <button type="button" @click="suggested = []">Hide</button>
    </div>
    <div class="selection-box">
      <ul>
        <li :key="clo.id" v-for="(clo, index) in suggested">
          <input type="checkbox" :id="'clo-suggested-' + index" :value="clo" v-model="selected">
          <label :for="'clo-suggested-' + index">{{ clo }}</label>
        </li>
      </ul>
    </div>
  </div>
  <div v-else>
    <strong>Suggested</strong>. No suggestions to show.
    <button type="button" @click="suggest()">Show</button>
  </div>

  <div class="scrollable-x mt-3">
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
          <td class="text-xs-center"
            v-for="(po, index) in supporting"
            :key="po.id">{{ typeof po.label !== 'undefined' ? po.label : (index + 1) }}</td>
        </template>
        <td v-else>&nbsp;</td>
      </tr>
      <tr :key="cloIndex" v-for="(clo, cloIndex) in c.courseLearningOutcomes">
        <td>
          <button type="button" @click="remove(cloIndex)" class="red--text">&times;</button>
          <button type="button" @click="add(cloIndex + 1)">+</button>
        </td>
        <td style="width: 0">{{ (cloIndex + 1) }}.</td>
        <td style="padding: 1px">
          <v-select
            label="Enter CLO"
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
          <template
            v-for="(po, poIndex) in supporting"
          >
            <td
              class="text-xs-center"
              :key="poIndex"
              style="padding: 0; position: relative"
            >
              <v-menu
                :key="poIndex"
                class="floating-td"
              >
                <div
                  slot="activator"
                  @mouseover="over(cloIndex, poIndex, $event)"
                  @mouseout="out(cloIndex, poIndex, $event)"
                  style="height: 100%; display: flex"
                >
                  <v-layout justify-center align-center>
                    <template v-if="
                      typeof c.cloPoMap[cloIndex] !== 'undefined' &&
                      Object.keys(c.cloPoMap[cloIndex]).indexOf(po.id) > -1
                    ">{{ c.cloPoMap[cloIndex][po.id].symbol }}</template>
                  </v-layout>
                </div>
                <v-list
                  dense
                  @mouseover.native="over(cloIndex, poIndex)"
                  @mouseout.native="out(cloIndex, poIndex)"
                >  
                  <template v-if="
                    typeof c.cloPoMap[cloIndex] !== 'undefined' &&
                    Object.keys(c.cloPoMap[cloIndex]).indexOf(po.id) > -1
                  ">
                    <v-list-tile @click="click(cloIndex, po.id)">
                      <v-list-tile-content>
                        <v-list-tile-title
                          class="red--text"
                          v-text="'Remove'"
                        />
                      </v-list-tile-content>
                    </v-list-tile>
                    <v-divider/>
                  </template>

                  <!-- assuming symbols come from db -->
                  <template v-for="(s, i) in symbols">
                    <v-list-tile :key="s.symbol" @click="click(cloIndex, po.id, s)">
                      <v-list-tile-content>
                        <v-list-tile-title>
                          {{ s.symbol }} &mdash; {{ s.text }}
                        </v-list-tile-title>
                      </v-list-tile-content>
                    </v-list-tile>
                    <v-divider
                      :key="'divider-' + s.symbol"
                      v-if="symbols.length-1 != i"
                    />
                  </template>

                </v-list>
              </v-menu>
            </td>
          </template>
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
import moveMap from '@/assets/js/moveMap'
import SuggestAlert from '@/include/generator/SuggestAlert'

export default {
  name: 'outcome-table',
  components: {
    SuggestAlert
  },
  props: {
    syllabus: Object,
    supporting: Array,
    mainTitle: String,
    supportingTitle: String
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
    searchInput: [],
    symbols: [
      {
        symbol: 'I',
        text: 'Introductory'
      },
      {
        symbol: 'E',
        text: 'Engaging'
      },
      {
        symbol: 'D',
        text: 'Demonstrative'
      },
    ]
  }),

  computed: {
    c() {
      return this.syllabus ? this.syllabus.content : null
    }
  },

  watch: {
    syllabus(to, from) {
      this.clear()
      if (to !== null) {
        this.doInitial()
      }
    },

    selected(to, from) {
      // set to syllabus once changed
      this.c.courseLearningOutcomes = to
    },
  },

  created() {
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)
    if (this.syllabus !== null) {
      this.doInitial()
    }
  },
  beforeDestroy() {
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },

  methods: {
    doInitial() {
      // set selected
      this.c.courseLearningOutcomes.forEach((e, i) => {
        // make selected only string
        // e.content
        this.$set(this.selected, i, typeof e === 'string' ? e : null)
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
        type: 1
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
      e ? e.target.classList.add('outcome-highlighted') : undefined
      let o = this.c.programOutcomes[po]
      this.highlighted = (typeof o.label !== 'undefined' ? o.label + '. ' : '') + o.content
    },
    out(clo, po, e) {
      e ? e.target.classList.remove('outcome-highlighted') : undefined
      this.highlighted = ''
    },
    click(clo, po, mark) {
      // check in map if exists
      if (typeof this.c.cloPoMap[clo] === 'undefined') {
        // make object instead
        this.$set(this.c.cloPoMap, clo, {})
      }

      // make it po: mark
      // this.c.cloPoMap[clo] => this is an object
      let map = this.c.cloPoMap[clo]

      if (typeof mark === 'undefined') {
        // delete this clo po pair
        this.$delete(map, po)
        return
      }

      this.$set(map, po, mark)
    },

    add(i) {
      this.selected.splice(i, 0, null)
      // move up
      this._updateMap(this.c.cloPoMap, i, 1)
    },
    remove(i) {
      this.selected.splice(i, 1)
      // move down
      this._updateMap(this.c.cloPoMap, i, -1)
    },

    _updateMap(map, i, n) {
      this.$bus.$emit('gen--clo.updated', i, n)
      this.c.cloPoMap = moveMap(map, i, n)
    },

    suggest() {
      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        return
      }
      // include book ids
      let bookIds = []
      if (typeof this.c.bookReferences !== 'undefined') {
        this.c.bookReferences.forEach(e => {
          bookIds.push(e.id)
        })
      }

      let po = this.c.programOutcomes
      let year = po.length ? po[0].year : 0

      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        type: 1,
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
