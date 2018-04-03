<template>
<div>
  
  <v-subheader>Level {{ index+1 }}</v-subheader>

  <div class="px-2 pb-2">
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
              :disabled="loading"
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
        >
          <v-tooltip top>
            <v-btn
              icon
              flat
              small
              color="error"
              slot="activator"
              @click="selected.splice(i, 1)"
              :disabled="loading"
            >
              <v-icon small>close</v-icon>
            </v-btn>
            <span>Remove</span>
          </v-tooltip>
          <icon-img
            :item="selected[i]"
            color="primary lighten-1"
            size="32"
            caption
          />
          <div
            class="subheader pl-3"
          >{{ $wrap.fullname(selected[i]) }}&nbsp;
            <add-me :id="selected[i].id"/>
          </div>
        </v-layout>
      </template>
    </v-list>
  </div>

  <v-layout>
    <v-spacer/>
    <v-btn
      color="primary lighten-1"
      @click="dialog = true"
      :disabled="loading"
    >
      <v-icon>add</v-icon>
      <span>Add User</span>
    </v-btn>
  </v-layout>

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
      <v-layout
        slot="item"
        slot-scope="props"
        align-center
      >
        <icon-img
          :item="selected[props.index]"
          color="primary lighten-1"
          size="32"
          caption
        />
        <div
          class="subheader pl-3"
          :class="{ 'primary--text text--lighten-1': props.isSelected }"
        >{{ $wrap.fullname(selected[props.index]) }}&nbsp;
          <add-me :id="selected[props.index].id"/>
        </div>
      </v-layout>
    </select-list>

    <select-list
      v-model="selected"
      :items.sync="items"
      :id="'user-' + index + '-'"
      max-height="25vh"
      :is-selected="(items, item) => items.map(e => e.id).indexOf(item.id) > -1"
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
        <span class="pl-2">
          <icon-img
            :item="props.item"
            color="primary lighten-1"
            size="32"
            caption
          />
        </span>
        <div
          class="subheader pl-3"
          :class="{ 'primary--text text--lighten-1': props.isSelected }"
        >{{ $wrap.fullname(props.item) }}&nbsp;
          <add-me :id="props.item.id"/>
        </div>
      </v-layout>
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import AddMe from '@/include/AddMe'
import IconImg from '@/include/IconImg'
import SelectList from '@/include/SelectList'

export default {
  name: 'workflow-level',
  components: {
    AddMe,
    IconImg,
    SelectList
  },
  props: {
    value: Object,
    index: [String, Number],
    loading: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    url: '/users',
    item: null,
    items: [],
    selected: [],

    dialog: false,
    search: null,
    dLoading: false
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
    loading(e) {
      this.dLoading = e
    },
    dLoading(e) {
      // this.$emit('update:loading', e)
    },

    selected(e) {
      this.item.users = e
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
      this.dLoading = true
      this.query()
    }
  },
  created() {
    this.item = this.value
    this.dLoading = this.loading
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
      this.dLoading = true
      this.$http.post(this.url, qs.stringify({
        search: search,
        auth: [5]
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.items = res.data.users
        this.dLoading = false
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
