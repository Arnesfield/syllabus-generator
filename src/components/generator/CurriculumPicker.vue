<template>
<div v-if="syllabus">

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
              <v-icon>touch_app</v-icon>
            </v-btn>
            <span>Choose curriculum</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title class="primary--text text--lighten-1">
            <template v-if="selected">{{ selected.label }}</template>
            <template v-else>Select a curriculum</template>
          </v-list-tile-title>
          <v-list-tile-sub-title>
            <template v-if="selected">Curriculum <strong v-text="selected.label"/> selected.</template>
            <template v-else>Select a curriculum</template>
          </v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>

      <!-- show suggested here -->
      <template v-if="suggested && (!selected || suggested.id != selected.id)">
        <v-divider/>
        <v-list-tile
          ripple
          @click="selected = suggested"
        >
          <v-list-tile-action class="thin-action">
            <v-tooltip top>
              <v-btn
                icon
                flat
                slot="activator"
                color="warning"
                @click="selected = suggested"
              >
                <v-icon>new_releases</v-icon>
              </v-btn>
              <span>Select suggested</span>
            </v-tooltip>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title
              class="warning--text"
              v-text="suggested.label"
            />
            <v-list-tile-sub-title>
              <span>Use the latest curriculum. Last updated in</span>
              <strong v-text="$moment.unix(suggested.updated_at).format('MMMM DD, YYYY h:mmA')"/>.
            </v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

    </v-list>
  </div>

  <v-layout>
    <v-spacer/>
    <v-btn
      color="primary lighten-1"
      @click="dialog = true"
    >
      <v-icon>touch_app</v-icon>
      <span>Choose curriculum</span>
    </v-btn>
  </v-layout>

  <div v-if="selected" class="mb-5 pr-2">
    <v-subheader>Curriculum&nbsp;<strong v-text="selected.label"/></v-subheader>
    <curriculum-view
      :item="selected"
      class="pl-3"
    />
  </div>

  <v-dialog
    v-model="dialog"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search curriculum"
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
      v-model="selectedArr"
      :items="selectedArr"
      id="selected-curriculum-"
      max-height="25vh"
      delete-mode
      editable
      align-center
      :is-selected="(allItems, item) => allItems.indexOf(item) > -1"
    >
      <template
        slot="title"
      >&nbsp;Selected</template>
      <v-layout
        slot="item"
        slot-scope="props"
      >
        <v-subheader>
          <div :class="{ 'primary--text text--lighten-1': props.isSelected }">
            <div v-html="props.item.label"/>
            <div
              class="caption"
              v-html="$moment.unix(props.item.updated_at).format('MMMM DD, YYYY h:mmA')"
            />
          </div>
        </v-subheader>
      </v-layout>
    </select-list>

    <select-list
      radio
      clearable
      v-model="selected"
      :items.sync="items"
      id="curriculum-"
      max-height="25vh"
      :is-selected="(allItems, item) => JSON.stringify(allItems) == JSON.stringify(item)"
    >
      <template
        slot="title"
      ><strong
        v-text="items.length"
      />&nbsp;{{ search ? 'Results' : 'Suggested' }}</template>
      <v-layout
        slot="item"
        slot-scope="props"
      >
        <v-subheader>
          <div :class="{ 'primary--text text--lighten-1': props.isSelected }">
            <div v-html="props.item.label"/>
            <div
              class="caption"
              v-html="$moment.unix(props.item.updated_at).format('MMMM DD, YYYY h:mmA')"
            />
          </div>
        </v-subheader>
      </v-layout>
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'
import CurriculumView from '@/include/CurriculumView'

export default {
  name: 'curriculum-picker',
  components: {
    SelectList,
    CurriculumView
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    url: '/curriculum',
    suggestUrl: '/curriculum/suggest',
    dialog: false,
    loading: false,

    selected: null,
    selectedArr: [],
    items: [],
    suggested: null,

    search: null
  }),
  watch: {
    syllabus(e) {
      this.setInitial()
    },

    selected(e) {
      this.selectedArr = e ? [e] : []
      // set this in syllabus
      // set changes to programOutcomes
      this.$set(this.syllabus.content, 'programOutcomes', e)
    },
    selectedArr(e) {
      if (!e.length) {
        this.selected = null
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
    this.setInitial()
  },
  beforeDestroy() {
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },

  methods: {
    setInitial() {
      // set from syllabus
      if (this.syllabus) {
        this.selected = this.syllabus.content.programOutcomes
      }
      this.suggest()
    },

    query: debounce(function(e) {
      const search = this.search
      if (!search) {
        this.items = []
        this.suggest()
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search,
        existing: true
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.items = res.data.curriculum
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggest() {
      this.loading = true
      this.$http.post(this.suggestUrl).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.items = res.data.curriculum
        if (res.data.curriculum.length) {
          this.suggested = res.data.curriculum[0]
        }
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
