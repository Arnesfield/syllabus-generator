<template>
<div>
  
  <v-layout justify-center>
    <v-btn
      block
      small
      color="primary lighten-1"
      @click="dialog = true"
    >
      <v-icon small>add</v-icon>
    </v-btn>
  </v-layout>

  <div
    v-if="selected.length"
    class="selection-box mt-2"
  >
    <ul>
      <li :key="i" v-for="(t, i) in selected">
        <v-layout align-baseline>
          <v-tooltip top>
            <v-btn
              icon
              small
              flat
              class="ma-0"
              slot="activator"
              @click="selected.splice(i, 1)"
            >
              <v-icon small color="error">close</v-icon>
            </v-btn>
            <span>Remove</span>
          </v-tooltip>
          <span v-html="$md.makeHtml(t)"/>
        </v-layout>
      </li>
    </ul>
  </div>

  <v-dialog
    v-model="dialog"
    width="800"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search keyword or enter topics"
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
      :id="'selected-topic-' + index + '-'"
      max-height="25vh"
      delete-mode
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
        <markdown-textarea
          edit-on-click
          v-model="selected[props.index]"
        />
      </template>
    </select-list>

    <select-list
      clearable
      v-model="selected"
      :items.sync="topics"
      :id="'topic-' + index + '-'"
      max-height="25vh"
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong
        v-text="topics.length"
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
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'topic-picker',
  components: {
    SelectList,
    MarkdownTextarea
  },
  props: {
    act: Object,
    syllabus: Object,
    index: Number,
    value: Array
  },
  data: () => ({
    url: '/topics',
    suggestUrl: '/topics/suggest',
    topics: [],
    selected: [],
    limit: 30,

    dialog: false,
    search: null,
    loading: false
  }),

  watch: {
    value(e) {
      this.selected = e
    },
    selected(to, from) {
      // set to topics in syllabus
      // this.act.topics = to
      // update topics on tla
      this.$emit('input', to)
      this.$bus.$emit('gen--topics.updated')
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
    this.$bus.$on('gen--suggestions.update', this.suggest)
    this.$bus.$on('gen--ilo.updated', this.suggest)
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)

    // set topics
    // if (this.act) {
    //   this.selected = this.act.topics
    // }
    this.selected = this.value

    // this.suggest()
  },
  beforeDestroy() {
    this.$bus.$off('gen--suggestions.update', this.suggest)
    this.$bus.$off('gen--ilo.updated', this.suggest)
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
        this.topics = []
        this.suggest()
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        console.warn(res.data)
        this.loading = false
        this.topics = res.data.topics
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggest(i) {
      // if same as index, proceed
      if (typeof i === 'number') {
        if (i != this.index) {
          return
        }
      }

      // do no execute sugget when bus suggestions is off
      if (!this.$bus.generator.suggestions) {
        this.loading = false
        return
      }

      // get books
      let books = this.syllabus.content.bookReferences

      // include clo content
      let cloContent = ''
      this.act.cloMap.forEach(e => {
        let clo = this.syllabus.content.courseLearningOutcomes[e]
        if (typeof clo !== 'undefined') {
          cloContent += ' ' + clo
        }
      })

      // include ilo content
      let iloContent = this.act.ilo.reduce((filtered, e) => filtered + ' ' + e, '')

      let outcomes = cloContent + iloContent;
      let poId = this.syllabus.content.programOutcomes.id

      this.loading = true
      this.$http.post(this.suggestUrl, qs.stringify({
        books: books,
        outcomes: outcomes,
        courseId: this.syllabus.course_id,
        curriculumId: poId,
        limit: this.limit
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.topics = res.data.topics
      }).catch((e) => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
