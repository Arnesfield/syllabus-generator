<template>
<td>
  
  <div>
    <v-btn
      small
      block
      color="primary lighten-1"
      @click="dialog = true"
    >Add ILO</v-btn>
  </div>

  <div
    v-if="selected.length"
    class="selection-box mt-2"
  >
    <ul>
      <li :key="i" v-for="(t, i) in selected">
        <button type="button" @click="selected.splice(i, 1)" class="red--text">&times;</button>
        <template>{{ t }}</template>
      </li>
    </ul>
  </div>

  <v-dialog
    v-model="dialog"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search keyword or enter ILO"
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
      id="selected-ilo-"
      max-height="25vh"
      editable
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong v-text="selected.length"/>&nbsp;Selected</template>
      <template
        slot="item"
        slot-scope="props"
      >
        <textarea
          class="my-textarea mt-2 mb-1"
          v-model="selected[props.index]"
        />
      </template>
    </select-list>

    <select-list
      v-model="selected"
      :items="outcomes"
      id="ilo-"
      max-height="25vh"
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong
        v-text="outcomes.length"
      />&nbsp;{{ search ? 'Results' : 'Suggested' }}</template>
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
      >{{ props.item }}</span>
    </select-list>

  </v-dialog>

</td>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'

export default {
  name: 'ilo-picker',
  components: {
    SelectList
  },
  props: {
    act: Object,
    syllabus: Object,
    index: Number
  },
  data: () => ({
    url: '/outcomes',
    suggestUrl: '/outcomes/suggest',
    outcomes: [],
    selected: [],
    suggested: [],

    dialog: false,
    search: null,
    loading: false
  }),

  watch: {
    selected(to, from) {
      this.act.ilo = to
      this.$bus.$emit('gen--ilo.updated')
    },
    dialog(e) {
      if (e) {
        this.suggest()
        this.$refs.searchbar.focus()
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
    this.$bus.$on('gen--suggestions.update', this.suggest)
    this.$bus.$on('gen--topics.updated', this.suggest)
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)

    // set ilo
    if (this.act) {
      this.selected = this.act.ilo
    }

    this.suggest()
  },
  beforeDestroy() {
    this.$bus.$off('gen--suggestions.update', this.suggest)
    this.$bus.$off('gen--topics.updated', this.suggest)
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },

  methods: {
    enterSearch() {
      this.selected.indexOf(this.search) == -1 ? this.selected.push(this.search) : undefined
    },

    query: debounce(function(e) {
      // search for book if not empty
      const search = this.search
      if (!search) {
        this.outcomes = []
        this.suggest()
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search,
        type: 2
      })).then((res) => {
        this.loading = false
        this.outcomes = res.data.outcomes
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggest() {
      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        this.loading = false
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

      // include clo content
      let cloContent = ''
      this.act.cloMap.forEach(e => {
        let clo = this.syllabus.content.courseLearningOutcomes[e]
        if (typeof clo !== 'undefined') {
          cloContent += ' ' + clo
        }
      })

      // include number of clos for limit
      let cloLimit = Object.keys(this.act.cloMap).length

      let po = this.syllabus.content.programOutcomes
      let year = po.length ? po[0].year : 0

      this.loading = true
      this.$http.post(this.suggestUrl, qs.stringify({
        bookIds: bookIds,
        cloContent: cloContent,
        topicIds: topicIds,
        courseId: this.syllabus.course_id,
        curriculumYear: year,
        type: 2,
        limit: 30,
        cloLimit: cloLimit
      })).then((res) => {
        this.loading = false
        this.outcomes = res.data.outcomes
      }).catch((e) => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
