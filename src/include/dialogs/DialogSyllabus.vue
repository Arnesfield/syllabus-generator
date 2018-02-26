<template>
<v-dialog
  v-model="show"
  width="1063"
  transition="fade-transition"
  scrollable
>
  <syllabus-inst :syllabus="syllabus"/>
</v-dialog>
</template>

<script>
import SyllabusInst from '@/include/SyllabusInst'

export default {
  name: 'dialog-syllabus',
  components: {
    SyllabusInst
  },
  data: () => ({
    syllabus: null,
    show: false
  }),
  created() {
    this.$bus.$on('dialog--syllabus.show', (e) => {
      this.syllabus = e
    })
  }
}
</script>
