<template>
<v-container
  v-if="c"
  fluid
  grid-list-lg
  class="pa-0"
>

  <v-list class="elevation-1 py-0 mt-2" two-line v-if="notLatest">
    <v-list-tile
      ripple
      @click="setContent(suggested, true)"
    >
      <v-list-tile-action class="thin-action">
        <v-tooltip top>
          <v-btn
            icon
            flat
            slot="activator"
            color="warning"
            @click="setContent(suggested, true)"
          >
            <v-icon>new_releases</v-icon>
          </v-btn>
          <span>Use latest content</span>
        </v-tooltip>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title
          class="warning--text"
          v-text="'Latest syllabus content available!'"
        />
        <v-list-tile-sub-title>
          <span>Use the latest syllabus content. Last updated at</span>
          <strong v-text="$moment.unix(suggestedDate).format('MMMM DD, YYYY h:mmA')"/>.
        </v-list-tile-sub-title>
      </v-list-tile-content>
    </v-list-tile>
  </v-list>

  <v-layout row wrap align-baseline>

    <!-- ivs -->
    <v-flex xs12 sm6>
      <v-subheader>Institution Vision Statement</v-subheader>
      <simple-list-content-view
        v-model="c.institutionVision"
        auto-edit-mode
        icon="visibility"
        title="Institution Vision Statement"
        subtitle="Enter Institution Vision Statement"
        placeholder="Enter Institution Vision Statement"
      />
    </v-flex>

    <!-- ims -->
    <v-flex xs12 sm6>
      <v-subheader>Institution Mission Statement</v-subheader>
      <simple-list-content-view
        v-model="c.institutionMission"
        auto-edit-mode
        icon="done_all"
        title="Institution Mission Statement"
        subtitle="Enter Institution Mission Statement"
        placeholder="Enter Institution Mission Statement"
      />
    </v-flex>
  </v-layout>


  <v-layout row wrap align-baseline>

    <!-- ivs -->
    <v-flex xs12 sm6>
      <v-subheader>Department Vision Statement</v-subheader>
      <simple-list-content-view
        v-model="c.departmentVision"
        auto-edit-mode
        icon="visibility"
        title="Department Vision Statement"
        subtitle="Enter Department Vision Statement"
        placeholder="Enter Department Vision Statement"
      />
    </v-flex>

    <!-- ims -->
    <v-flex xs12 sm6>
      <v-subheader>Department Mission Statement</v-subheader>
      <simple-list-content-view
        v-model="c.departmentMission"
        auto-edit-mode
        icon="done_all"
        title="Department Mission Statement"
        subtitle="Enter Department Mission Statement"
        placeholder="Enter Department Mission Statement"
      />
    </v-flex>
  </v-layout>

  <v-layout>
    <v-flex xs12 sm10>
      <v-subheader>Program Educational Objectives</v-subheader>
      <simple-list-content-view
        v-model="c.programEducationalObjectives"
        auto-edit-mode
        class="mb-3"
        icon="done_all"
        title="Program Educational Objectives"
        subtitle="Enter Program Educational Objectives"
        placeholder="Enter Program Educational Objectives"
      />
    </v-flex>
  </v-layout>

</v-container>
</template>

<script>
import SimpleListContentView from '@/include/SimpleListContentView'
const keys = [
  'institutionVision',
  'institutionMission',
  'departmentVision',
  'departmentMission',
  'programEducationalObjectives',
]

export default {
  name: 'syllabus-content',
  components: {
    SimpleListContentView
  },
  props: {
    value: Object,
    syllabusContent: Object
  },
  data: () => ({
    url: '/settings/syllabus_content',
    syllabus: null,
    suggested: null,
    loading: false
  }),
  watch: {
    value(e) {
      this.syllabus = e
      this.fetch()
    },
    syllabus: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
      }
    },
    syllabusContent(e) {
      this.setContent(e)
    }
  },
  computed: {
    c() {
      return this.syllabus ? this.syllabus.content : null
    },
    notLatest() {
      // loop through suggested
      if (this.suggested === null) {
        return false
      }
      return !keys.every(e => this.suggested[e] === this.c[e])
    }
  },

  created() {
    this.syllabus = this.value
    this.fetch()
  },

  methods: {
    setContent(content, force) {
      if (!this.c) {
        return
      }
      if (typeof force !== 'boolean') {
        force = false
      }
      keys.forEach(e => {
        this.c[e] = this.c[e] && !force ? this.c[e] : content[e]
      })
    },

    fetch() {
      if (!this.c) {
        return
      }
      
      // get values from db instead
      this.loading = true
      this.$http.post(this.url).then(res => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        let content = res.data.syllabusContent.content
        this.suggested = content
        this.suggestedDate = res.data.syllabusContent.updated_at
        this.setContent(content)
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
