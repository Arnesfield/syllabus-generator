<template>
<v-list
  two-line
  class="elevation-1 py-0"
>
  <v-list-tile @click="() => {}">
    <v-list-tile-action class="thin-action">
      <v-icon color="primary lighten-1">{{ icon }}</v-icon>
    </v-list-tile-action>
    <v-list-tile-content>
      <v-list-tile-title
        v-text="title"
        class="primary--text text--lighten-1"
      />
      <v-list-tile-sub-title v-text="subtitle"/>
    </v-list-tile-content>
  </v-list-tile>

  <v-divider/>

  <v-layout
    align-center
    class="px-2 py-3 ml-1 mr-3"
  >
    <markdown-textarea
      edit-on-click
      :md-view="view"
      :placeholder="placeholder"
      v-model="item"
      t-add-class="my-medium-textarea pa-2 elevation-4"
    />
  </v-layout>
</v-list>
</template>

<script>
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'simple-list-content-view',
  components: {
    MarkdownTextarea
  },
  props: {
    value: String,
    icon: String,
    title: String,
    subtitle: String,
    placeholder: String,
    mdView: {
      type: Boolean,
      default: true
    },
    autoEditMode: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    item: null,
    view: null
  }),
  watch: {
    value(e) {
      this.item = e
    },
    item(e) {
      this.$emit('input', e)
    },

    mdView(e) {
      this.view = e
    },
    view(e) {
      this.$emit('update:mdView', e)
    }
  },
  created() {
    this.item = this.value
    this.view = this.mdView
    if (this.autoEditMode && !this.item) {
      this.view = false
    }
  }
}
</script>
