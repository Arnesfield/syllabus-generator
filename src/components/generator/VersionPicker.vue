<template>
<v-layout
  justify-center
  align-center
  style="min-height: calc(100vh - 256px)"
>
  <div class="full-width mt-2">
    <div class="grey--text text--darken-1 text-xs-center mb-3">
      <div class="subheading mb-1">Major or minor revisions from last syllabus?</div>
      <div class="caption">Choose any if this is the first version.</div>
    </div>
    
    <v-layout row wrap style="min-height: 320px; height: 320px">
      <v-flex
        xs12
        sm6
        md6
        lg6
        class="full-height"
      >
        <version-card
          dark
          :class="{
            blue: versionType != 0,
            orange: versionType == 0
          }"
          :selected="versionType == 0"
          @click.native="versionType = 0"
        >
          <div
            slot="title"
            class="display-1"
          >Major</div>
          <div
            slot="subtitle"
            class="caption"
          >v2.2 => v3.0</div>
        </version-card>
      </v-flex>

      <simple-circle-separator
        xs12
        class="hidden-sm-and-up"
      />
      <simple-circle-separator class="hidden-xs-only"/>

      <v-flex
        xs12
        sm6
        md6
        lg6
        class="full-height"
      >
        <version-card
          dark
          :class="{
            'blue darken-1': versionType != 1,
            orange: versionType == 1
          }"
          :selected="versionType == 1"
          @click.native="versionType = 1"
        >
          <div
            slot="title"
            class="display-1"
          >Minor</div>
          <div
            slot="subtitle"
            class="caption"
          >v2.2 => v2.3</div>
        </version-card>
      </v-flex>

    </v-layout>
  </div>
</v-layout>
</template>

<script>
import VersionCard from '@/include/VersionCard'
import SimpleCircleSeparator from '@/include/SimpleCircleSeparator'

export default {
  name: 'version-picker',
  components: {
    VersionCard,
    SimpleCircleSeparator
  },
  props: {
    value: Number,
    courseId: [Number, String]
  },
  data: () => ({
    url: '/syllabus/version',
    versionType: null,
    loading: false
  }),
  watch: {
    value(e) {
      this.versionType = e
    },
    versionType(e) {
      this.$emit('input', e)
    },
    loading(e) {
    }
  },

  created() {
    this.versionType = this.value
    this.fetch()
  },

  methods: {
    fetch() {
      // check for latest version in db
    }
  }
}
</script>
