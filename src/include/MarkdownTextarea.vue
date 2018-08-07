<template>
<v-layout align-center>
  <v-tooltip top style="align-self: flex-start">
    <v-btn
      icon
      small
      flat
      slot="activator"
      color="grey darken-1"
      @click="viewAsMd = !viewAsMd"
    >
      <v-icon small v-if="viewAsMd">edit</v-icon>
      <v-icon small v-else>text_format</v-icon>
    </v-btn>
    <span v-if="viewAsMd">Edit</span>
    <span v-else>Format</span>
  </v-tooltip>

  <div
    style="width: calc(100% - 46px)"
    class="my-2"
  >
    <span
      v-if="viewAsMd"
      v-html="$md.makeHtml(text)"
      :class="{
        [mdClass + ' ' + mdAddClass]: true,
        'clickable hoverable': editOnClick
      }"
      @click="mdClick"
    />
    <vue-editor
      v-else
      :placeholder="placeholder + (required ? '*' : '')"
      ref="textarea"
      v-model="text"
      :id="textareaId"
      @blur="textareaBlur"
    />

    <div
      class="red--text caption"
      v-if="errorMsg"
      v-text="errorMsg"
    />
  </div>

  <!-- lol for required -->
  <v-text-field
    style="display: none"
    v-model="text"
    v-if="required"
    :rules="[ (required ? $fRule('required') : () => true) ]"
  />
</v-layout>
</template>

<script>
import { VueEditor } from 'vue2-editor'

export default {
  name: 'markdown-textarea',
  components: {
    VueEditor
  },
  props: {
    value: String,
    textareaId: {
      type: String,
      default: 'quill-container'
    },
    textareaClass: {
      type: String,
      default: 'my-textarea elevation-1 pa-1 yellow lighten-4'
    },
    tAddClass: {
      type: String,
      default: ''
    },
    mdClass: {
      type: String,
      default: 'my-list py-2'
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
    },
    editOnClick: {
      type: Boolean,
      default: false
    },
    required: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    text: null,
    viewAsMd: true,
    errorMsg: null
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.errorMsg = null
        this.text = e
        if (!this.text && this.viewAsMd) {
          this.$nextTick(() => {
            this.viewAsMd = false
          })
        }
      }
    },
    text: {
      deep: true,
      handler(e) {
        if (e) {
          this.errorMsg = null
        }
        this.$emit('input', e)
      }
    },
    mdView(e) {
      this.viewAsMd = e
    },
    viewAsMd(e) {
      if (!e) {
        this.$nextTick(() => {
          if (this.$refs.textarea) {
            this.$refs.textarea.quill.focus()
          }
        })
      }
    }
  },
  created() {
    this.text = this.value
    // do not view as md if text is empty
    this.viewAsMd = typeof this.text === 'string' && this.text.length > 0 ? this.mdView : false
  },
  methods: {
    mdClick() {
      this.editOnClick ? this.viewAsMd = !this.viewAsMd : undefined
    },
    textareaBlur() {
      if (this.required && !this.text) {
        this.errorMsg = 'This field is required.'
      } else if (this.text && this.text.trim().length) {
        setTimeout(() => {
          // this.viewAsMd = true
        }, 100)
      }
    },
    reset() {
      this.text = this.value
      this.viewAsMd = this.mdView
      this.errorMsg = null
    }
  }
}
</script>

<style>
.ql-container {
  background-color: #fff9c4 !important;
}
</style>
