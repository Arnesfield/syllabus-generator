<template>
<v-layout
  align-center
  class="body-1 primary--text text--lighten-1"
>
  <v-icon
    small
    color="primary lighten-1"
  >{{ icon }}</v-icon>
  <div class="ml-1">{{ text }}</div>
</v-layout>
</template>

<script>
export default {
  name: 'simple-small-header-text',
  props: {
    text: String,
    icon: String
  }
}
</script>
