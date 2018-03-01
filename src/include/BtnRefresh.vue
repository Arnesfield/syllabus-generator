<template>
  <v-tooltip
    :left="tip === 'left'"
    :right="tip === 'right'"
    :top="tip === 'top'"
    :bottom="tip === 'bottom'"
  >
    <v-btn
      icon
      @click="$bus.$emit(click)"
      slot="activator"
    >
      <v-progress-circular
        indeterminate
        :width="6"
        :size="18"
        v-if="refresh"
      />
      <v-icon v-else>refresh</v-icon>
    </v-btn>
    <span v-if="refresh">Refreshing</span>
    <span v-else>Refresh</span>
  </v-tooltip>
</template>

<script>
export default {
  name: 'btn-refresh',
  props: {
    click: String,
    refresh: Boolean,
    tip: {
      type: String,
      default: 'left'
    }
  }
}
</script>
