<template>
<v-select
  :items="items"
  :disabled="loading"
  v-model="status"
  label="Status"
  single-line
  :prepend-icon="status && status.icon ? status.icon : 'indeterminate_check_box'"
  return-object
  bottom
  :rules="[ (required ? $fRule('required') : () => true) ]"
  color="primary lighten-1"
  :required="required"
>
  <template slot="item" slot-scope="data">
    
    <template v-if="typeof data.item !== 'object'">
      <v-list-tile-content v-text="data.item"></v-list-tile-content>
    </template>

    <template v-else>
      <v-list-tile-avatar>
        <v-icon
          :color="data.item.color"
        >{{ data.item.icon }}</v-icon>
      </v-list-tile-avatar>
      <v-list-tile-content>
        <v-list-tile-title v-text="data.item.text"></v-list-tile-title>
      </v-list-tile-content>
    </template>

  </template>
</v-select>
</template>

<script>
export default {
  name: 'select-status',
  props: {
    value: Object,
    items: Array,
    loading: Boolean,
    required: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    status: null
  }),
  watch: {
    value(e) {
      this.status = e
    },
    status(e) {
      this.$emit('input', e)
    }
  },
  created() {
    this.status = this.value
  }
}
</script>
