<template>
<strong
  class="caption grey--text"
  style="font-weight: bold"
  v-if="$bus.session.user.id == id"
>(me)</strong>
</template>

<script>
export default {
  name: 'add-me',
  props: {
    id: [Number, String]
  }
}
</script>
