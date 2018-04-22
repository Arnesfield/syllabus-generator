<template>
<li class="no-wrap" style="list-style-type: disc">

  <span
    @click="toggle"
    :class="{
      'bold clickable': isExpandable,
      'lighten-2': !isExpandable && !isSelected,
      'accent': isSelected,
      'blue': !isSelected
    }"
    class="blue white--text px-2 py-1 my-1"
    style="display: inline-block; font-size: 1.25rem"
  >{{ item.code }}
    <span v-if="isExpandable">[{{ open ? '-' : '+' }}]</span>
  </span>
  <a
    class="blue--text caption"
    style="text-decoration: underline"
    @click="() => { select(item.id) }"
  >info</a>

  <course-tree-related-view
    v-show="open"
    v-if="hasPrerequisite"
    :items="item.prerequisites"
    text="Prerequisites"
    @select="select"
    :selected-id="selectedId"
  />
  <course-tree-related-view
    v-show="open"
    v-if="hasCorequisite"
    :items="item.corequisites"
    text="Corequisites"
    @select="select"
    :selected-id="selectedId"
  />

</li>
</template>

<script>
import CourseTreeRelatedView from '@/include/CourseTreeRelatedView'

export default {
  name: 'course-tree-view',
  components: {
    CourseTreeRelatedView
  },
  props: {
    item: Object,
    selectedId: {
      type: [Number, String],
      default: undefined
    }
  },
  data: () => ({
    open: false
  }),
  computed: {
    hasPrerequisite() {
      return this.item.prerequisites && this.item.prerequisites.length
    },
    hasCorequisite() {
      return this.item.corequisites && this.item.corequisites.length
    },
    isExpandable() {
      return this.hasPrerequisite || this.hasCorequisite
    },
    isSelected() {
      return this.item ? this.item.id == this.selectedId : false
    }
  },
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
      if (this.isExpandable) {
        this.open = !this.open
      }
    },
    select(id) {
      this.$emit('select', id)
    }
  }
}
</script>
