<template>
<v-layout>
  <v-tooltip top>
    <v-btn
      icon
      small
      flat
      slot="activator"
      color="primary"
      @click="viewAsMd = !viewAsMd"
    >
      <v-icon small v-if="viewAsMd">edit</v-icon>
      <v-icon small v-else>text_format</v-icon>
    </v-btn>
    <span v-if="viewAsMd">Edit</span>
    <span v-else>Format</span>
  </v-tooltip>

  <span
    v-if="viewAsMd"
    v-html="$md.makeHtml(text)"
    :class="{ [mdClass + ' ' + mdAddClass]: true }"
  />
  <textarea
    v-else
    v-model="text"
    :placeholder="placeholder"
    :class="{ [textareaClass + ' ' + tAddClass]: true }"
  />
</v-layout>
</template>

<script>
export default {
  name: 'markdown-textarea',
  props: {
    value: String,
    textareaClass: {
      type: String,
      default: 'my-textarea my-2 elevation-1 pa-1 white'
    },
    tAddClass: {
      type: String,
      default: ''
    },
    mdClass: {
      type: String,
      default: 'my-ul mt-2 mb-1'
    },
    mdAddClass: {
      type: String,
      default: ''
    },
    placeholder: {
      type: String,
      default: 'Enter text here'
    },
    mdView: {
      type: Boolean,
      default: true
    }
  },
  data: () => ({
    text: null,
    viewAsMd: true
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.text = e
      }
    },
    text: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
      }
    },
    mdView(e) {
      this.viewAsMd = e
    }
  },
  created() {
    this.text = this.value
    this.viewAsMd = this.mdView
  }
}
</script>
