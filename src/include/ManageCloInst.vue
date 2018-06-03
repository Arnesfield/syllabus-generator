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
  name: 'manage-clo-inst',
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
    totalVisible: 10
  }),

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
