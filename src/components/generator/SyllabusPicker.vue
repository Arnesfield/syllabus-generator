<template>
<div v-if="course">

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
              <v-icon>layers</v-icon>
            </v-btn>
            <span>Choose version</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title class="primary--text text--lighten-1">
            <template v-if="selected">{{ selected.version || 'New syllabus' }}</template>
            <template v-else>Select a version</template>
          </v-list-tile-title>
          <v-list-tile-sub-title>
            <template v-if="selected">
              <span>Syllabus</span>
              <strong
                v-if="selected.version"
                v-text="selected.version"
              />
              <span>selected.</span>
            </template>
            <template v-else>Select a version to use as basis</template>
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
              v-text="suggested.version"
            />
            <v-list-tile-sub-title>
              <span>Use the latest version. Last updated in</span>
              <strong v-text="$moment.unix(suggested.updated_at).format('MMMM DD, YYYY h:mmA')"/>.
            </v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>
    </v-list>
  </div>

  <v-layout row wrap>
    <v-spacer class="hidden-xs-only"/>
    <v-btn
      color="warning"
      @click="startScratch"
    >
      <v-icon>new_releases</v-icon>&nbsp;
      <span>Create new</span>
    </v-btn>
    <v-btn
      color="primary lighten-1"
      @click="dialog = true"
    >
      <v-icon>layers</v-icon>
      <span>Choose version</span>
    </v-btn>
  </v-layout>

  <template v-if="selected">
    <v-divider class="mt-2"/>
    <syllabus-content
      v-model="selected"
      :syllabus-content="syllabusContent"
    />
  </template>

  <v-dialog
    v-model="dialog"
    width="800"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbar"
      label="Search versions"
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
      :is-selected="(allItems, item) => JSON.stringify(allItems) == JSON.stringify(item)"
    >
      <template
        slot="title"
      >&nbsp;Selected</template>
      <div
        slot="item"
        slot-scope="props"
        class="primary--text text--lighten-1"
        v-text="props.item.version || 'New syllabus'"
      />
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
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
        v-text="props.item.version"
      />
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import SelectList from '@/include/SelectList'
import SyllabusContent from '@/components/generator/SyllabusContent'

export default {
  name: 'syllabus-picker',
  components: {
    SelectList,
    SyllabusContent
  },
  props: {
    value: Object,
    syllabusContent: Object,
    course: {
      type: Object,
      default: null
    }
  },
  data: () => ({
    url: '/syllabi',
    suggestUrl: '/syllabi/suggest',

    dialog: false,
    loading: false,

    selected: null,
    selectedArr: [],
    items: [],
    suggested: null,

    search: null
  }),
  watch: {
    value(e) {
      this.selected = e
    },
    selected(e) {
      if (e && e.content && e.content.versionType !== null) {
        e.content.versionType = null
      }
      this.selectedArr = e ? [e] : []
      this.$emit('input', e)
    },
    course(e) {
      if (e) {
        this.suggest()
      }
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
    this.selected = this.value
    this.suggest()
  },
  beforeDestroy() {
    this.$bus.$off('watch--generator.suggestions', this.suggest)
  },

  methods: {
    startScratch() {
      // syllabus structure here
      let syllabus = {
        course_id: this.course.id,
        content: {
          institutionVision: null,
          institutionMission: null,
          departmentVision: null,
          departmentMission: null,
          programEducationalObjectives: null,
          imgSrc: null,

          facultyInCharge: this.$bus.session.user,
          evaluatedBy: [],
          approvedBy: [],

          bookReferences: [],
          programOutcomes: null,
          courseLearningOutcomes: [],
          cloPoMap: {},
          weeklyActivities: [],
          gradingSystem: [],
          versionType: null
        }
      }

      this.selected = syllabus
    },

    query: debounce(function(e) {
      const search = this.search
      if (!search) {
        this.items = []
        this.suggest()
        return
      }

      if (!this.course) {
        this.loading = false
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        courseId: this.course.id,
        noEmpty: true,
        search: search
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.items = res.data.syllabi
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggest() {
      if (!this.course) {
        this.loading = false
        return
      }

      this.loading = true
      this.$http.post(this.suggestUrl, qs.stringify({
        courseId: this.course.id
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.items = res.data.syllabi
        if (res.data.syllabi.length) {
          this.suggested = res.data.syllabi[0]
        }
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
