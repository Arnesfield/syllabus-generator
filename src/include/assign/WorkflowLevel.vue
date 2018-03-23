<template>
<div>
  Level
</div>
</template>

<script>
export default {
  name: 'workflow-level',
  props: {
    value: Object
  },
  data: () => ({
    item: null
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.item = e
      }
    },
    item: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
      }
    }
  },
  created() {
    this.item = this.value
  }
}
</script>
