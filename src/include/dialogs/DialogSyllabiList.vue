<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="dialog-bottom-transition"
  width="800"
  scrollable
  fullscreen
>
  <v-card>
    
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
        :disabled="loading"
        @click="show = false"
        @keypress.enter="show = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Syllabi</v-toolbar-title>
    </v-toolbar>

    <v-card-text>
      
    </v-card-text>
  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import filter from 'lodash/filter'

export default {
  name: 'dialog-syllabi-list',
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
