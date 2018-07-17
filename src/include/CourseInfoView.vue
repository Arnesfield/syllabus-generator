<template>
<v-card
  hover
  ripple
  class="clickable smooth-bg-and-shadow course-view"
  @click.native="$emit('view', item)"
>
<div class="full-height">
  <v-layout class="full-height">
    
    <div
      style="width: 24px; height: calc(100% + 16px)"
      :class="{ [sideColor]: true }"
    />

    <div class="full-width full-height">
      <v-card-title class="px-3 pt-3 pb-0">
        <div>
          <div
            class="title mb-2"
            v-text="item.code"
          />
          <div
            class="caption grey--text text--darken-1 mb-1"
            v-text="item.title"
          />
        </div>
      </v-card-title>

      <v-card-text class="px-2 pt-0 pb-2">
        <div>
          <v-chip
            :key="i-1"
            v-for="i in totalVisibleTags(item)"
          >{{ item.tags[i-1] }}</v-chip>
        </div>
      </v-card-text>
    </div>

  </v-layout>
</div>
</v-card>
</template>

<script>
export default {
  name: 'course-info-view',
  props: {
    item: Object,
    slim: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    dSlim: false,
    colors: {
      wma: 'yellow',
      agd: 'blue',
      da: 'green',
      smba: 'red'
    }
  }),

  computed: {
    totalVisible() {
      return this.dSlim ? 3 : -1
    },
    sideColor() {
      let color = null
      const colorKeys = Object.keys(this.colors)
      // loop through tags and check 
      this.item.tags.every(e => {
        // if tag is in color keys
        let tag = e.toLowerCase()
        if (colorKeys.includes(tag)) {
          color = this.colors[tag]
          return false
        }
        return true
      })
      return color || 'grey lighten-1'
    }
  },

  watch: {
    slim(e) {
      this.dSlim = e
    },
    dSlim(e) {
      this.$emit('update:slim', e)
    }
  },

  created() {
    this.dSlim = this.slim
  },

  methods: {
    totalVisibleTags(item) {
      if (this.totalVisible === -1) {
        return item.tags.length
      }
      return item.tags.length > this.totalVisible
        ? this.totalVisible : item.tags.length
    },
  }
}
</script>
