<template>
<v-card
  hover
  ripple
  @click.native="selectItem"
  @keypress.enter="selectItem"
  tabindex="0"
  class="clickable"
  :class="{ 'yellow lighten-4': isSelected }"
  style="position: relative; height: 100%"
>
  <div>
    <v-layout>
      <div
        style="padding-top: 14px; padding-bottom: 10px"
        class="pa-3 full-width"
      >
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
          <v-spacer/>
          <status
            :item="value"
            :msg="statusMsg"
            v-if="!report"
          />
          <template v-if="closable">
            <v-tooltip top>
              <v-btn
                icon
                small
                slot="activator"
                @click="closeItem"
              >
                <v-icon
                  small
                  color="grey"
                >close</v-icon>
              </v-btn>
              <span>Remove</span>
            </v-tooltip>
          </template>
        </v-layout>
        <v-layout
          class="pb-2"
        >
          <div
            v-html="$md.makeHtml(value.content)"
            class="px-2 pt-2"
            :class="{ 'primary--text text--darken-2': isSelected }"
          />
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

  <div
    class="selectedCheck"
    v-if="isSelected"
  >
    <v-btn
      icon
      small
      color="blue lighten-5"
    >
      <v-icon medium color="blue">check_circle</v-icon>
    </v-btn>
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
    value: Object,
    report: {
      type: Boolean,
      default: false
    },
    isSelected: {
      type: Boolean,
      default: false
    },
    closable: {
      type: Boolean,
      default: false
    }
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

    selectItem() {
      this.$emit('select', this.value)
    },
    closeItem() {
      this.$emit('close', this.value)
    }
  }
}
</script>

<style scoped>
.selectedCheck {
  position: absolute;
  top: 0;
  right: 0;
  transform: translate(18px, -16px)
}
</style>
