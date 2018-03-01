<template>
<v-list-tile
  ripple
  v-if="assign"
  @click="$emit('view', assign)"
>
  <v-list-tile-action>
    <status :item="assign"/>
  </v-list-tile-action>
  <v-list-tile-content>
    <v-list-tile-title>
      <v-layout>
        <v-flex xs12 md4 v-text="course().code"/>
        <v-flex
          xs12
          md4
          hidden-xs-only
          v-text="$wrap.fullname(assigned())"/>
        <v-flex xs12 md4 hidden-xs-only>
          <div
            class="caption"
          >Last update:
          <template
            v-if="assign.updated_at != assign.created_at"
          >{{ $wrap.datetime(assign.updated_at, true, false) }}</template>
          <strong v-else>None</strong>
          </div>
        </v-flex>
      </v-layout>
    </v-list-tile-title>
    <v-list-tile-sub-title>
      <v-layout hidden-xs-only hidden-sm-only class="full-width">
        <v-flex xs12 md4 v-text="course().title"/>
        <v-flex xs12 md4>Assigned</v-flex>
        <v-flex
          xs12
          md4
          class="caption"
        >Created: {{ $wrap.datetime(assign.created_at, true, false) }}</v-flex>
      </v-layout>
    </v-list-tile-sub-title>
  </v-list-tile-content>
  <!-- <v-list-tile-action>
    <v-tooltip top>
      <v-btn
        icon
        slot="activator"
        @click="$emit('view', assign)"
      >
        <v-icon color="grey">visibility</v-icon>
      </v-btn>
      <span>View</span>
    </v-tooltip>
  </v-list-tile-action> -->
</v-list-tile>
</template>

<script>
import Status from '@/include/Status'

export default {
  name: 'workflow-inst',
  components: {
    Status
  },
  props: {
    assign: {
      type: Object,
      required: true
    }
  },

  methods: {
    createSyllabus() {
      this.$router.push('/generator/' + this.assign.id)
    },
    course() {
      return this.assign.content.course
    },
    assigned() {
      return this.assign.content.assigned
    },
    sub() {
      return this.assign.content.sub
    }
  }
}
</script>
