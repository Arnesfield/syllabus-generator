<template>
<v-layout
  row align-center
  v-if="remarks"
  class="elevation-1"
>
  <v-tooltip top>
    <v-btn
      icon
      slot="activator"
    >
      <v-icon color="grey">subject</v-icon>
    </v-btn>
    <span>Remarks</span>
  </v-tooltip>
  <div
    class="pr-3 py-3 grey--text text--darken-2"
  >{{ remarks }}</div>
</v-layout>
</template>

<script>
export default {
  name: 'remarks-inst',
  props: {
    remarks: [Object, String]
  }
}
</script>
