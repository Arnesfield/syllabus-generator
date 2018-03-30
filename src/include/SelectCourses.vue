<template>
<div>

  <v-btn
    color="primary lighten-1"
    @click="dialog = true"
    :disabled="dLoading"
    v-if="courses.length === 0"
  >
    <v-icon>school</v-icon>
    &nbsp;
    <span>{{ btn }}</span>
  </v-btn>
  <template v-else>
    <v-layout align-center>
      <v-tooltip top>
        <v-btn
          icon
          small
          slot="activator"
          @click="dialog = true"
          :disabled="dLoading"
        >
          <v-icon
            small
            color="grey darken-1"
          >edit</v-icon>
        </v-btn>
        <span>{{ btn }}</span>
      </v-tooltip>

      <div>
        <template v-for="(item, i) in courses">
          <v-tooltip top :key="i">
            <v-chip
              close
              label
              slot="activator"
              @input="courses.splice(i, 1)"
            >{{ item.code }}</v-chip>
            <span>{{ item.title }}</span>
          </v-tooltip>
        </template>
      </div>

    </v-layout>
  </template>

  <v-dialog
    v-model="dialog"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      :label="label"
      prepend-icon="search"
      :append-icon="search ? 'close' : undefined"
      :append-icon-cb="search ? () => { search = null } : undefined"
      v-model="search"
      :loading="dLoading"
    />

    <v-progress-linear
      :active="dLoading"
      :indeterminate="true"
      color="accent"
      class="my-0"
      :height="dLoading ? 3 : 0"
      background-color="white"
    />

    <select-list
      v-model="courses"
      :items="courses"
      id="selected-course-"
      max-height="25vh"
      align-center
      delete-mode
      editable
      :is-selected="(allItems, item) => allItems.indexOf(item) > -1"
    >
      <template
        slot="title"
      >&nbsp;Selected</template>
      <v-layout
        slot="item"
        slot-scope="props"
        align-center
      >
        <v-subheader>
          <div>
            <div v-html="props.item.code"/>
            <div class="caption" v-html="props.item.title"/>
          </div>
        </v-subheader>
        
        <v-spacer/>

        <v-tooltip left>
          <v-icon
            color="grey"
            slot="activator"
          >info_outline</v-icon>
          <div
            style="max-width: 420px"
            v-html="props.item.description"
          />
        </v-tooltip>
      </v-layout>
    </select-list>

    <select-list
      clearable
      v-model="courses"
      :items.sync="items"
      id="courses-"
      max-height="25vh"
      :is-selected="(allItems, item) => allItems.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong
        v-text="items.length"
      />&nbsp;{{ search ? 'Results' : 'Suggested' }}</template>
      <v-layout
        slot="item"
        slot-scope="props"
        align-center
      >
        <v-subheader>
          <div>
            <div v-html="props.item.code"/>
            <div class="caption" v-html="props.item.title"/>
          </div>
        </v-subheader>

        <v-spacer/>

        <v-tooltip left>
          <v-icon
            color="grey"
            slot="activator"
          >info_outline</v-icon>
          <div
            style="max-width: 420px"
            v-html="props.item.description"
          />
        </v-tooltip>
      </v-layout>
    </select-list>

  </v-dialog>
</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'

export default {
  name: 'select-courses',
  components: {
    SelectList
  },
  props: {
    value: Array,
    label: {
      type: String,
      default: 'Courses'
    },
    placeholder: {
      type: String,
      default: undefined
    },
    color: {
      type: String,
      default: 'primary'
    },
    disabled: Boolean,
    required: {
      type: Boolean,
      default: false
    },
    courseId: {
      type: [String, Number],
      default: null
    },
    btn: {
      type: String,
      default: 'Select course/s'
    }
  },
  data: () => ({
    url: '/courses',
    search: null,
    courses: [],
    items: [],
    dLoading: false,
    dialog: false
  }),
  watch: {
    courses(to, from) {
      this.$emit('input', to)
    },
    value(e) {
      this.courses = e
    },
    dialog(e) {
      if (e) {
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
      this.dLoading = true
      this.query()
    },
  },
  created() {
    this.courses = this.value
  },

  methods: {
    filterSearch(item, queryText, itemText) {
      const getValue = val => val != null ? val.toString().toLowerCase() : ''
      const title = getValue(item.title)
      const code = getValue(item.code)
      const query = getValue(queryText)
      return title.indexOf(query) > -1 || code.indexOf(query) > -1
    },

    query: debounce(function(e) {
      const search = this.search
      if (!search) {
        this.items = []
        this.suggest()
        return
      }

      this.dLoading = true
      this.$http.post(this.url, qs.stringify({
        search: search,
        exceptId: this.courseId || null
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.dLoading = false
        this.items = res.data.courses
      }).catch(e => {
        console.error(e)
        this.dLoading = false
      })
    }, 300),

    suggest() {
      this.dLoading = false

    }
  }
}
</script>
