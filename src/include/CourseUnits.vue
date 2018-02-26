<template>
<span>
  <template v-if="Number(course.unitsLec)"
    >{{ course.unitsLec }} {{ course.unitsLec == 1 ? 'Unit' : 'Units' }} LEC
  </template>
  <template v-if="Number(course.unitsLec) && Number(course.unitsLab)">/</template>
  <template v-if="Number(course.unitsLab)"
    >{{ course.unitsLab }} {{ course.unitsLab == 1 ? 'Unit' : 'Units' }} LAB
  </template>
</span>
</template>

<script>
export default {
  name: 'course-units',
  props: {
    course: Object
  }
}
</script>
