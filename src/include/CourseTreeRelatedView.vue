<template>
<ul>
  <li style="list-style-type: circle">
    <span
      @click="toggle"
      class="bold clickable grey--text"
    >{{ text }}
      <span>[{{ open ? '-' : '+' }}]</span>
    </span>
    <ul v-show="open">
      <course-tree-view
        :key="i"
        :item="item"
        v-for="(item, i) in items"
        @select="select"
        :selected-id="selectedId"
      />
    </ul>
  </li>
</ul>
</template>

<script>
export default {
  name: 'course-tree-related-view',
  props: {
    text: String,
    items: Array,
    selectedId: {
      type: [Number, String],
      default: undefined
    }
  },
  data: () => ({
    open: false
  }),
  watch: {
    '$bus.toolbar.course.collapse': function(e) {
      this.open = !e
    }
  },

  created() {
    this.open = !this.$bus.toolbar.course.collapse
  },

  methods: {
    toggle() {
      this.open = !this.open
    },
    select(id) {
      this.$emit('select', id)
    }
  }
}
</script>
