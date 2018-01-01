<template>
<div v-if="syllabus">
  <div>Version: {{ syllabus.content.version }}</div>
  <div v-if="editor">Editor: {{ editor.fname + ' ' + editor.mname + ' ' + editor.lname }}</div>
</div>
</template>

<script>
export default {
  name: 'syllabus-info',
  props: {
    syllabus: Object,
    editor: Object
  }
}
</script>
