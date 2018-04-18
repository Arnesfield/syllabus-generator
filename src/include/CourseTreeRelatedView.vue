<template>
<ul>
  <li>
    <div
      @click="toggle"
      class="bold clickable blue--text"
    >{{ text }}
      <span>[{{ open ? '-' : '+' }}]</span>
    </div>
    <ul v-show="open">
      <course-tree-view
        :key="i"
        :item="item"
        v-for="(item, i) in items"
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
    items: Array
  },
  data: () => ({
    open: false
  }),

  methods: {
    toggle() {
      this.open = !this.open
    }
  }
}
</script>
