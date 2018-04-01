<template>
<div v-if="!$bus.generator.suggestions && $bus.generator.warn" class="mb-2">
  <v-alert
    type="warning"
    v-model="$bus.generator.warn"
    dismissible
    transition="fade-transition"
  >
    <span>Suggestions are off.</span>
    <v-btn
      @click="$bus.generator.suggestions = true"
      class="primary--text my-0"
      small
    >Turn On</v-btn>
  </v-alert>
</div>
</template>

<script>
export default {
  name: 'suggest-alert'
}
</script>
