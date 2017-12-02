<template>
<div>
  <div>
    <router-view/>
  </div>
</div>
</template>

<script>
export default {
  name: 'dashboard',
  created() {
    this.$emit('update-nav')
  }
}
</script>
