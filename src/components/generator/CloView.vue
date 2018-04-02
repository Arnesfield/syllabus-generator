<template>
<div>

  <div class="pa-2">
    <v-list class="elevation-1 py-0" two-line>
      <v-list-tile
        ripple
        @click="dialog = true"
      >
        <v-list-tile-action class="thin-action">
          <v-tooltip top>
            <v-btn
              icon
              flat
              slot="activator"
              color="primary"
              @click="dialog = true"
            >
              <v-icon>school</v-icon>
            </v-btn>
            <span>Add/Select CLO</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title
            v-text="'Add/Select CLO'"
            class="primary--text text--lighten-1"
          />
          <v-list-tile-sub-title v-text="'Total CLO: ' + selected.length"/>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </div>

  <v-divider class="mb-3 mt-2"/>
  <outcome-mapper-table
    ref="outcomeMapperTable"
    v-model="c.courseLearningOutcomes"
    :po="c.programOutcomes"
    :content="c"
    @highlighted="(e) => { highlighted = e }"
  />

  <v-container
    fluid
    grid-list-lg
    class="mt-3 pa-0"
    style="min-height: 180px"
  >
    <v-layout row wrap>
      <v-flex xs12 sm6>
        <v-list
          class="py-0 smooth-height"
          :class="{
            'elevation-1': highlighted === null,
            'elevation-4': highlighted !== null,
          }"
        >
          <v-list-tile>
            <v-list-tile-action class="thin-action">
              <v-icon
                :color="highlighted ? 'warning' : undefined"
              >lightbulb_outline</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title
                :class="{ 'warning--text': highlighted }"
                v-text="'Highlighted'"
              />
              <v-list-tile-sub-title/>
            </v-list-tile-content>
          </v-list-tile>
          
          <template v-if="highlighted">
            <v-divider/>
            <v-layout class="pa-2 mx-3 my-2">
              <curriculum-view :item="highlighted"/>
            </v-layout>
          </template>

        </v-list>
      </v-flex>

      <v-flex xs12 sm6>
        <v-layout row wrap>
          <v-spacer class="hidden-xs-only"/>
          <v-btn
            color="warning"
            @click="dialog = true"
          >
            <v-icon>new_releases</v-icon>&nbsp;
            <span>View suggestions</span>
          </v-btn>
          <v-btn
            color="primary lighten-1"
            @click="add(c.courseLearningOutcomes.length)"
          >
            <v-icon>add</v-icon>
            <span>Add CLO</span>
          </v-btn>
        </v-layout>
      </v-flex>
    </v-layout>
  </v-container>

  <v-dialog
    v-model="dialog"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search keyword or enter CLO"
      :prepend-icon="search ? 'add' : 'search'"
      :prepend-icon-cb="search ? enterSearch : undefined"
      :append-icon="search ? 'close' : undefined"
      :append-icon-cb="search ? () => { search = null } : undefined"
      v-model="search"
      @keypress.enter.native="enterSearch"
      :loading="loading"
    />

    <v-progress-linear
      :active="loading"
      :indeterminate="true"
      color="accent"
      class="my-0"
      :height="loading ? 3 : 0"
      background-color="white"
    />

    <select-list
      v-model="selected"
      :items="selected"
      :id="'selected-outcome-'"
      max-height="25vh"
      delete-mode
      editable
      :is-selected="(allItems, item) => allItems.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong v-text="selected.length"/>&nbsp;Selected</template>
      <template
        slot="item"
        slot-scope="props"
      >
        <markdown-textarea
          v-model="selected[props.index]"
        />
      </template>
    </select-list>

    <select-list
      clearable
      v-model="selected"
      :items.sync="items"
      id="outcomes-"
      max-height="25vh"
      :is-selected="(allItems, item) => allItems.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong
        v-text="items.length"
      />&nbsp;{{ search ? 'Results' : 'Suggested' }}</template>
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
        v-html="$md.makeHtml(props.item)"
      />
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'
import CurriculumView from '@/include/CurriculumView'
import MarkdownTextarea from '@/include/MarkdownTextarea'
import OutcomeMapperTable from '@/components/generator/OutcomeMapperTable'

export default {
  name: 'clo-view',
  components: {
    SelectList,
    CurriculumView,
    MarkdownTextarea,
    OutcomeMapperTable
  },
  props: {
    value: Object
  },
  data: () => ({
    url: '/outcomes',
    suggestUrl: '/outcomes/suggest',

    items: [],
    selected: [],
    suggested: [],
    highlighted: null,

    syllabus: null,
    
    dialog: false,
    search: null,
    loading: false
  }),

  computed: {
    c() {
      return this.syllabus ? this.syllabus.content : null
    }
  },

  watch: {
    value: {
      deep: true,
      handler(to, from) {
        this.syllabus = to
        if (to !== from) {
          this.setInitial()
        }
      }
    },
    syllabus: {
      deep: true,
      handler(e) {
        if (e.content.courseLearningOutcomes !== this.selected) {
          this.selected = e.content.courseLearningOutcomes
        }
        this.$emit('input', e)
      }
    },

    selected(e) {
      if (this.c.courseLearningOutcomes !== e) {
        this.c.courseLearningOutcomes = e
      }
    },

    dialog(e) {
      if (e) {
        this.suggest()
        setTimeout(() => {
          if (this.$refs.searchbar) {
            this.$refs.searchbar.focus()
          }
        })
      } else {
        this.search = null
      }
    },
    search(e) {
      this.loading = true
      this.query()
    }
  },

  created() {
    this.$bus.$on('watch--generator.suggestions', this.suggest)
    this.syllabus = this.value
    // bind outcomes
    this.selected = this.c.courseLearningOutcomes
    this.setInitial()
  },
  beforeDestroy() {
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },

  methods: {
    setInitial() {
      if (!this.c) {
        return
      }
      // set selected
      // clear selected first
      this.selected = []
      this.c.courseLearningOutcomes.forEach((e, i) => {
        // make selected only string
        // e.content
        this.$set(this.selected, i, typeof e === 'string' ? e : null)
      })
      this.suggest()
    },

    add(i) {
      if (this.$refs.outcomeMapperTable) {
        this.$refs.outcomeMapperTable.add(i)
      }
    },

    enterSearch() {
      this.selected.indexOf(this.search) == -1 ? this.selected.push(this.search) : undefined
    },

    query: debounce(function(e) {
      // search for book if not empty
      const search = this.search
      if (!search) {
        this.items = []
        this.suggest()
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        type: 1,
        search: search
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.items = res.data.outcomes
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggest() {
      this.loading = false

    }
  }
}
</script>
