<template>
<div>
  <h1>Dashboard</h1>
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
