<template>
<div>
  <div>From: {{ week.from }}</div>
  <div>Until: {{ week.until }}</div>
</div>
</template>

<script>
export default {
  name: 'activity-week',
  props: {
    week: Object
  }
}
</script>
