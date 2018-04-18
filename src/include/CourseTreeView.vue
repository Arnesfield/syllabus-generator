<template>
<li>

  <div
    @click="toggle"
    @dblclick="select"
    :class="{ 'bold': isExpandable }"
    class="clickable"
  >{{ item.code }}
    <span v-if="isExpandable">[{{ open ? '-' : '+' }}]</span>
  </div>

  <course-tree-related-view
    v-show="open"
    v-if="hasPrerequisite"
    :items="item.prerequisites"
    text="Prerequisites"
  />
  <course-tree-related-view
    v-show="open"
    v-if="hasCorequisite"
    :items="item.corequisites"
    text="Corequisites"
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
    item: Object
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
    }
  },

  methods: {
    toggle() {
      if (this.isExpandable) {
        this.open = !this.open
      }
    },
    select() {
      
    }
  }
}
</script>
