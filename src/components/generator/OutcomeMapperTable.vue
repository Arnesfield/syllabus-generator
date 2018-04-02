<template>
<div class="scrollable-x elevation-1">
  <table class="syllabus-tbl no-outside-border">
    <tr>
      <th colspan="2" rowspan="2" style="min-width: 256px; width: 50%">Course Learning Outcomes (CLO)</th>
      <th :colspan="po.content.length">Program Outcomes</th>
    </tr>

    <tr>
      <!-- <td colspan="2">&nbsp;</td> -->
      <template v-if="po.content.length">
        <td
          class="text-xs-center"
          v-for="(p, i) in po.content"
          :key="i"
        >{{ p.label }}</td>
      </template>
      <td v-else>&nbsp;</td>
    </tr>

    <tr
      :key="cloIndex"
      v-for="(clo, cloIndex) in outcomes"
    >
      <td style="width: 0" class="text-xs-center">
        <div>
          <div v-text="cloIndex + 1 + '.'"/>
          <v-tooltip top>
            <v-btn
              icon
              small
              flat
              class="ma-0"
              slot="activator"
              @click="remove(cloIndex)"
            >
              <v-icon small color="error">close</v-icon>
            </v-btn>
            <span>Remove {{ cloIndex + 1 }}</span>
          </v-tooltip>
        </div>
      </td>
      <td style="padding: 1px; min-width: 256px; width: 50%">
        <div class="pr-2">
          <markdown-textarea
            placeholder="Enter CLO"
            :md-view="false"
            edit-on-click
            v-model="outcomes[cloIndex]"
          />
        </div>
      </td>
      <template v-if="po.content.length">
        <td
          :key="poIndex"
          v-for="(p, poIndex) in po.content"
          class="text-xs-center"
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
              <v-layout justify-center align-center class="smooth-bg-color">
                <template v-if="
                  typeof c.cloPoMap[cloIndex] !== 'undefined' &&
                  Object.keys(c.cloPoMap[cloIndex]).indexOf(p.label) > -1
                ">{{ c.cloPoMap[cloIndex][p.label].symbol }}</template>
              </v-layout>
            </div>
            <v-list
              dense
              @mouseover.native="over(cloIndex, poIndex)"
              @mouseout.native="out(cloIndex, poIndex)"
            >  
              <template v-if="
                typeof c.cloPoMap[cloIndex] !== 'undefined' &&
                Object.keys(c.cloPoMap[cloIndex]).indexOf(p.label) > -1
              ">
                <v-list-tile @click="click(cloIndex, p.label)">
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
                <v-list-tile :key="s.symbol" @click="click(cloIndex, p.label, s)">
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
      <td v-else>&nbsp;</td>
    </tr>

  </table>
</div>
</template>

<script>
import moveMap from '@/assets/js/moveMap'
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'outcome-mapper-table',
  components: {
    MarkdownTextarea
  },
  props: {
    value: Array,
    po: Object,
    content: Object
  },
  data: () => ({
    url: '/settings/clo_options',
    outcomes: [],
    symbols: [],
    highlighted: null
  }),
  watch: {
    value(e) {
      this.outcomes = e
    },
    outcomes(e) {
      this.$emit('input', e)
    },
    highlighted(e) {
      this.$emit('highlighted', e)
    }
  },
  computed: {
    c() {
      return this.content
    }
  },
  created() {
    this.outcomes = this.value
    this.fetchCloOptions()
  },

  methods: {
    fetchCloOptions(n) {
      if (typeof n !== 'number') {
        n = 0
      }

      this.$http.post(this.url).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.symbols = res.data.cloOptions.content
      }).catch(e => {
        console.error(e)
        // fetch until it gets it lol
        // stop if it repeats more than 10 times
        if (n < 10) {
          this.fetchCloOptions(n + 1)
        }
      })
    },

    over(clo, po, e) {
      e ? e.target.classList.add('grey', 'lighten-2') : undefined
      this.highlighted = {
        content: [ this.po.content[po] ]
      }
    },
    out(clo, po, e) {
      e ? e.target.classList.remove('grey', 'lighten-2') : undefined
      this.highlighted = null
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
      this.outcomes.splice(i, 0, null)
      // move up
      this._updateMap(this.c.cloPoMap, i, 1)
    },
    remove(i) {
      this.outcomes.splice(i, 1)
      // move down
      this._updateMap(this.c.cloPoMap, i, -1)
    },
    _updateMap(map, i, n) {
      this.c.cloPoMap = moveMap(map, i, n)
      this.$bus.$emit('gen--clo.updated', i, n)
    }
  }
}
</script>
