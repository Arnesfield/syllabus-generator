<template>
<div v-if="!$bus.generator.suggestions" class="mt-3 mb-3">
  <v-alert class="elevation-1" type="warning" :value="true">
    <span>Suggestions are off.</span>
    <v-btn
      @click="$bus.generator.suggestions = true"
      class="primary--text"
      small>Turn On</v-btn>
  </v-alert>
</div>
</template>

<script>
export default {
  name: 'suggest-alert'
}
</script>
