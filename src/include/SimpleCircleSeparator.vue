<template>
<v-flex
  :xs12="xs12"
>
  <v-layout
    style="position: relative"
    class="full-height"
    align-center
    justify-center
  >
    <v-btn
      fab
      large
      absolute
      color="white"
      :class="btnClass"
      :ripple="false"
    >{{ text }}</v-btn>
  </v-layout>
</v-flex>
</template>

<script>
export default {
  name: 'simple-circle-separator',
  props: {
    text: {
      type: String,
      default: 'or'
    },
    btnClass: {
      type: String,
      default: 'blue--text'
    },
    xs12: {
      type: Boolean,
      default: false
    }
  }
}
</script>
