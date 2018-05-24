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
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search keyword or enter materials"
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
      :id="'selected-materials-' + index + '-'"
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
          v-model="selected[props.index]"
        />
      </template>
    </select-list>

    <select-list
      clearable
      v-model="selected"
      :items.sync="materials"
      :id="'materials-' + index + '-'"
      max-height="25vh"
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong
        v-text="materials.length"
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
  name: 'instructional-materials',
  components: {
    SelectList,
    MarkdownTextarea
  },
  props: {
    act: Object,
    syllabus: Object,
    index: Number
  },
  data: () => ({
    url: '/materials',
    suggestUrl: '/materials/suggest',
    materials: [],
    selected: [],
    limit: 30,

    dialog: false,
    search: null,
    loading: false
  }),

  watch: {
    selected(to, from) {
      this.act.instructionalMaterials = to
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
    this.$bus.$on('gen--topics.updated', this.suggest)
    // do suggest when bus generator suggestions changes
    this.$bus.$on('watch--generator.suggestions', this.suggest)

    // set materials
    if (this.act) {
      this.selected = this.act.instructionalMaterials
    }

    this.suggest()
  },
  beforeDestroy() {
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
        this.materials = []
        this.suggest()
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        console.warn(res.data)
        this.loading = false
        this.materials = res.data.materials
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
      
      // get books
      let books = this.syllabus.content.bookReferences

      // include topic
      let topics = this.act.topics

      let poId = this.syllabus.content.programOutcomes.id

      this.loading = true
      this.$http.post(this.suggestUrl, qs.stringify({
        books: books,
        topics: topics,
        courseId: this.syllabus.course_id,
        curriculumId: poId,
        limit: this.limit
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.materials = res.data.materials
      }).catch((e) => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
