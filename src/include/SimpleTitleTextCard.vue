<template>
<v-card v-if="item">
  <template v-if="!fixedTitle">
    <v-text-field
      solo
      flat
      v-model="item[label]"
      :prepend-icon="icon"
      :append-icon-cb="removable ? () => { $emit('remove', index) } : undefined"
      :append-icon="removable ? 'close' : undefined"
      :placeholder="placeholder"
    />
  </template>
  <v-layout
    v-else
    align-center
  >
    <v-btn
      icon
      :ripple="false"
    >
      <v-icon color="primary lighten-1">{{ icon }}</v-icon>
    </v-btn>
    <div
      class="primary--text text--lighten-1"
      v-text="label"
    />
    <template v-if="removable">
      <v-spacer/>
      <v-btn
        icon
        @click="removable ? () => { $emit('remove', index) } : undefined"
      >
        <v-icon color="grey">close</v-icon>
      </v-btn>
    </template>
  </v-layout>
  <v-divider/>
  <div class="mr-3 pa-2">
    <markdown-textarea
      edit-on-click
      v-model="item[text]"
      :placeholder="item[label] ? 'Enter ' + item[label] + ' here' : 'Enter grading here'"
      t-add-class="my-big-textarea pa-2"
    />
  </div>
</v-card>
</template>

<script>
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'simple-title-text-card',
  components: {
    MarkdownTextarea
  },
  props: {
    value: Object,
    index: Number,
    icon: {
      type: String,
      default: undefined
    },
    label: {
      type: String,
      default: 'label'
    },
    text: {
      type: String,
      default: 'text'
    },
    placeholder: {
      type: String,
      default: 'Enter text here'
    },
    fixedTitle: {
      type: Boolean,
      default: false
    },
    removable: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    item: null
  }),
  watch: {
    value(e) {
      this.item = e
    },
    item: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
      }
    }
  },
  created() {
    this.item = this.value
  }
}
</script>
