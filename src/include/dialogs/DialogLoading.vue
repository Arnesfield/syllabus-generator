<template>
<v-dialog
  v-model="show"
  :persistent="true"
  width="200"
  transition="fade-transition"
>
  <v-card>
    <v-card-text>
      <v-layout>
        <v-progress-circular
          :indeterminate="true"
          :size="48"
          color="primary"
        />
        <span
          class="subheading ml-3"
          style="align-self: center"
        >Loading...</span>
      </v-layout>
    </v-card-text>
  </v-card>
</v-dialog>
</template>

<script>
export default {
  name: 'dialog-loading',
  data: () => ({
    show: false
  }),

  created() {
    this.$bus.$on('dialog--loading', this.dialogLoading)
  },
  beforeDestroy() {
    this.$bus.$off('dialog--loading', this.dialogLoading)
  },

  methods: {
    dialogLoading(e) {
      this.show = e
    }
  }
}
</script>
