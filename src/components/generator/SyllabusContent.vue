<template>
<v-container
  v-if="c"
  fluid
  grid-list-lg
  class="pa-0"
>
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
import content from '@/assets/js/content'
import SimpleListContentView from '@/include/SimpleListContentView'

export default {
  name: 'syllabus-content',
  components: {
    SimpleListContentView
  },
  props: {
    value: Object
  },
  data: () => ({
    url: '',
    syllabus: null
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
    }
  },
  computed: {
    c() {
      return this.syllabus ? this.syllabus.content : null
    }
  },

  created() {
    this.syllabus = this.value
    this.fetch()
  },

  methods: {
    fetch() {
      if (!this.c) {
        return
      }
      
      // get values from db instead
      const keys = [
        'institutionVision',
        'institutionMission',
        'departmentVision',
        'departmentMission',
        'programEducationalObjectives',
      ]
      keys.forEach(e => {
        this.c[e] = this.c[e] || content[e]
      })
    }
  }
}
</script>
