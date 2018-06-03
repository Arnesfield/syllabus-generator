<template>
<v-card
  hover
  ripple
  @click.native="editItem"
  @keypress.enter="editItem"
  tabindex="0"
  class="clickable"
>
  <div>
    <v-layout>
      <status
        :item="value"
        :msg="statusMsg"
      />
      <div
        style="padding-top: 14px; padding-bottom: 10px"
        class="pr-3"
      >
        <div
          v-html="$md.makeHtml(value.content)"
          class="pb-1"
        />
        <v-layout
          v-if="type"
          align-center
        >
          <v-icon
            small
            :color="type.color"
            class="pa-2"
          >{{ type.icon }}</v-icon>
          <div class="caption grey--text text--darken-1 pr-2">{{ type.text }}</div>
        </v-layout>
        <div>
          <v-chip
            :key="i-1"
            v-for="i in totalVisibleTags(value)"
          >{{ value.tags[i-1] }}</v-chip>
        </div>
      </div>
    </v-layout>
  </div>
</v-card>
</template>

<script>
import Status from '@/include/Status'

export default {
  name: 'manage-outcome-inst',
  components: {
    Status
  },
  props: {
    value: Object
  },

  data: () => ({
    statusMsg: {
      0: 'Deactivated',
      1: 'Activated',
      2: 'Undecided',
      3: 'Not yet submitted'
    },
    types: {
      1: { text: 'Course Learning Outcomes (CLO)', icon: 'notes', color: 'primary lighten-1' },
      2: { text: 'Intended Learning Ouctomes (ILO)', icon: 'short_text', color: 'blue' },
      3: { text: 'Faculty: Teaching and Learning Activities (TLA)', icon: 'school', color: 'accent' },
      4: { text: 'Student: Teaching and Learning Activities (TLA)', icon: 'assignment', color: 'warning' }
    },

    totalVisible: 10
  }),

  computed: {
    type() {
      return this.value ? this.types[this.value.type] : null
    }
  },

  methods: {
    totalVisibleTags(item) {
      if (this.totalVisible === -1) {
        return item.tags.length
      }
      return item.tags.length > this.totalVisible
        ? this.totalVisible : item.tags.length
    },

    editItem() {
      this.$emit('edit', this.value)
    }
  }
}
</script>
