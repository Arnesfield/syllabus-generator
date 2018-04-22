<template>
<div v-if="item">

  <!-- units -->
  <div>
    <simple-small-header-text
      class="mb-1"
      text="Units / Type"
      icon="format_list_numbered"
    />
    <div>
      <course-units :course="item"/>
    </div>
  </div>
  
  <!-- description -->
  <div
    class="mt-3"
    v-if="item.description && item.description.length"
  >
    <simple-small-header-text
      class="my-1"
      text="Description"
      icon="description"
    />
    <div
      class="my-list"
      v-html="$md.makeHtml(item.description)"
    />
  </div>
  
  <!-- objectives -->
  <div
    class="mt-3"
    v-if="item.objectives && item.objectives.length"
  >
    <simple-small-header-text
      class="my-1"
      text="Objectives"
      icon="done_all"
    />
    <div
      class="my-list"
      v-html="$md.makeHtml(item.objectives)"
    />
  </div>

  <!-- prerequisites -->
  <div
    v-if="item.prerequisites && item.prerequisites.length"
    class="mt-3"
  >
    <simple-small-header-text
      class="my-1"
      text="Prerequisites"
      icon="school"
    />
    <related-course-chips
      :courses="item.prerequisites"
      @select="selectCourse"
    />
  </div>

  <!-- corequisites -->
  <div
    v-if="item.corequisites && item.corequisites.length"
    class="mt-3"
  >
    <simple-small-header-text
      class="my-1"
      text="Corequisites"
      icon="school"
    />
    <related-course-chips
      :courses="item.corequisites"
      @select="selectCourse"
    />
  </div>

  <!-- tags -->
  <div
    v-if="item.tags && item.tags.length"
    class="mt-3"
  >
    <simple-small-header-text
      class="my-1"
      text="Related tags"
      icon="label"
    />
    <div>
      <v-chip
        :key="i"
        v-for="(tag, i) in item.tags"
      >{{ tag }}</v-chip>
    </div>
  </div>

</div>
</template>

<script>
import CourseUnits from '@/include/CourseUnits'
import RelatedCourseChips from '@/include/RelatedCourseChips'
import SimpleSmallHeaderText from '@/include/SimpleSmallHeaderText'

export default {
  name: 'detailed-course-info',
  components: {
    CourseUnits,
    RelatedCourseChips,
    SimpleSmallHeaderText
  },
  props: {
    item: Object
  },

  methods: {
    selectCourse(id, code) {
      this.$emit('select', id, code)
    }
  }
}
</script>
