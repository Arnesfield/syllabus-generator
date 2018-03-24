<template>
<div>
  
  <v-subheader>Level {{ index+1 }}</v-subheader>

  <div class="px-2 pb-2">
    <v-list class="elevation-1 py-0" two-line>
      <v-list-tile>
        <v-list-tile-action class="thin-action">
          <v-tooltip top>
            <v-btn
              icon
              flat
              slot="activator"
              color="primary"
              @click="dialog = true"
            >
              <v-icon>add</v-icon>
            </v-btn>
            <span>Add user</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title v-text="'Selected users'"/>
          <v-list-tile-sub-title v-text="'Total users selected: ' + selected.length"/>
        </v-list-tile-content>
      </v-list-tile>
      <template v-for="(t, i) in selected">
        <v-divider :key="'divider-' + i"/>
        <v-layout
          :key="'layout-' + i"
          align-center
          class="pr-2"
          style=""
        >
          <v-tooltip top style="align-self: flex-start">
            <v-btn
              icon
              flat
              small
              color="error"
              slot="activator"
              @click="selected.splice(i, 1)"
            >
              <v-icon small>close</v-icon>
            </v-btn>
            <span>Remove</span>
          </v-tooltip>
          <div v-html="$wrap.fullname(selected[i])"/>
        </v-layout>
      </template>
    </v-list>
  </div>

  <v-btn
    color="primary lighten-1"
    @click="dialog = true"
  >
    <v-icon>add</v-icon>
    <span>Add User</span>
  </v-btn>

  <v-dialog
    v-model="dialog"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search user"
      prepend-icon="search"
      :append-icon="search ? 'close' : undefined"
      :append-icon-cb="search ? () => { search = null } : undefined"
      v-model="search"
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
      :id="'selected-user-' + index + '-'"
      max-height="25vh"
      align-center
      delete-mode
      editable
      :is-selected="(items, item) => items.indexOf(item) > -1"
    >
      <template
        slot="title"
      ><strong v-text="selected.length"/>&nbsp;Selected</template>
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
        v-html="$wrap.fullname(selected[props.index])"
      />
    </select-list>

    <select-list
      v-model="selected"
      :items.sync="items"
      :id="'user-' + index + '-'"
      max-height="25vh"
      :is-selected="(items, item) => items.indexOf(item) > -1"
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
        v-html="$wrap.fullname(props.item)"
      />
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'

export default {
  name: 'workflow-level',
  components: {
    SelectList
  },
  props: {
    value: Object,
    index: [String, Number]
  },
  data: () => ({
    url: '/users/search',
    item: null,
    items: [],
    selected: [],

    dialog: false,
    search: null,
    loading: false
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.item = e
      }
    },
    item: {
      deep: true,
      handler(e) {
        this.setInitial()
        this.$emit('input', e)
      }
    },

    selected(e) {
      this.item.users = e
    },
    dialog(e) {
      if (e) {
        this.suggest()
        setTimeout(() => {
          this.$refs.searchbar.focus()
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
    this.item = this.value
    this.setInitial()
  },

  methods: {
    setInitial() {
      if (typeof this.item.users === 'undefined') {
        this.$set(this.item, 'users', this.selected)
      } else {
        this.selected = this.item.users
      }
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
        search: search
      })).then((res) => {
        this.items = res.data.users
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }),

    suggest() {
      this.loading = false

    }
  }
}
</script>
