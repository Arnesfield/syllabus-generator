<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="dialog-bottom-transition"
  width="800"
  scrollable
  fullscreen
>
  <v-card class="grey lighten-5">
    
    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      background-color="primary lighten-1"
      class="ma-0 primary lighten-1"
    />

    <v-toolbar
      dark
      card
      color="primary lighten-1"
    >
      <v-btn
        icon
        dark
        @click="show = false"
        @keypress.enter="show = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>{{ title }}</v-toolbar-title>
    </v-toolbar>

    <v-card-text class="pa-0 full-height">
      <v-container
        fluid
        grid-list-lg
        :fill-height="!syllabi.length"
      >
        <v-layout
          row
          wrap
          v-if="syllabi.length"
        >
          <v-flex
            xs12
            sm6
            md4
            lg3
            :key="i"
            v-for="(syllabus, i) in syllabi"
          >
            <selectable-syllabus-view
              :item="syllabus"
            />
          </v-flex>
        </v-layout>
        <v-layout
          v-else
          align-center
          justify-center
        >
          <manage-no-data
            msg="No results :("
            :fetch="fetch"
            :loading="loading"
          >
            <v-icon
              slot="icon"
              size="64px"
              class="mb-4"
            >assignment_late</v-icon>
          </manage-no-data>
        </v-layout>
      </v-container>
    </v-card-text>
  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import filter from 'lodash/filter'
import SelectableSyllabusView from '@/include/SelectableSyllabusView'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'dialog-syllabi-list',
  components: {
    SelectableSyllabusView,
    ManageNoData
  },
  props: {
    items: Array
  },
  data: () => ({
    url: '/syllabi/outcomes',
    syllabi: [],
    show: false,
    loading: false
  }),

  watch: {
    show(e) {
      e ? this.fetch() : e
    },
    loading(e) {
      this.$bus.refresh(e)
    }
  },

  computed: {
    title() {
      if (this.loading) {
        return 'Loading'
      }
      let n = this.syllabi.length
      if (!n) {
        return 'No Results'
      }
      return n === 1 ? '1 Syllabus Result' : n + ' Syllabi Results'
    },
    filterItems() {
      let items = {}
      for (let i = 1; i <= 4; i++) {
        items[i] = // filter(this.items, { type: String(i) })
        this.items.reduce((filtered, e) => {
          if (e.type == i) {
            filtered.push(e.content)
          }
          return filtered
        }, [])
      }
      return items
    }
  },

  methods: {
    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        outcomes: this.filterItems
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.syllabi = res.data.syllabi
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
