<template>
<v-snackbar
  :timeout="timeout"
  :top="y === 'top'"
  :bottom="y === 'bottom'"
  :right="x === 'right'"
  :left="x === 'left'"
  :multi-line="mode === 'multi-line'"
  :vertical="mode === 'vertical'"
  v-model="snackbar">
  {{ text }}
  <v-btn
    flat
    color="primary"
    @click.native="callCb">Close</v-btn>
</v-snackbar>
</template>

<script>
export default {
  name: 'snackbar',
  data: () => ({
    snackbar: false,
    x: 'left',
    y: 'bottom',
    mode: '',
    timeout: 4000,
    text: '',
    cb: null
  }),
  
  created() {
    this.$bus.$on('show-snackbar', (text, cb, options) => {
      let hasValue = (val, prop) => typeof prop === 'undefined' ? val : prop
      this.text = text
      this.cb = typeof cb === 'function' ? cb : null
      // default
      if (typeof options === 'undefined') {
        this.x = 'left'
        this.y = 'bottom'
        this.mode = ''
        this.timeout = 4000
      } else {
        this.x = hasValue(this.x, options.x)
        this.y = hasValue(this.y, options.y)
        this.mode = hasValue(this.mode, options.mode)
        this.timeout = hasValue(this.timeout, options.timeout)
      }
      this.snackbar = true
    })
  },

  methods: {
    callCb(e) {
      typeof this.cb === 'function'
        ? this.cb(this, e)
        : snackbar = false
    }
  }
}
</script>
