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
      <v-icon small v-if="viewAsMd">visibility_off</v-icon>
      <v-icon small v-else>visibility</v-icon>
    </v-btn>
    <span v-if="viewAsMd">View as textarea</span>
    <span v-else>View as markdown</span>
  </v-tooltip>

  <span
    v-if="viewAsMd"
    v-html="$md.makeHtml(text)"
    :class="{ [mdClass]: true }"
  />
  <textarea
    v-else
    v-model="text"
    :class="{ [textareaClass]: true }"
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
      default: 'my-textarea mt-2 mb-1'
    },
    mdClass: {
      type: String,
      default: 'mt-2 mb-1'
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
    }
  },
  created() {
    this.text = this.value
  }
}
</script>
