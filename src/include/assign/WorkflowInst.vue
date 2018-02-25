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
    <v-list-tile-title v-text="course().code"/>
    <v-list-tile-sub-title>
      <div>{{ course().title }}</div>
      <div>Assigned to:
        <strong>{{ $wrap.fullname(assigned()) }}</strong>
      </div>
    </v-list-tile-sub-title>
  </v-list-tile-content>
  <v-list-tile-action>
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
  </v-list-tile-action>
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
