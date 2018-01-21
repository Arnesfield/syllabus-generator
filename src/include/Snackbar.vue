<template>
<v-snackbar
  :timeout="timeout"
  :top="y === 'top'"
  :bottom="y === 'bottom'"
  :right="x === 'right'"
  :left="x === 'left'"
  :multi-line="mode === 'multi-line'"
  :vertical="mode === 'vertical'"
  v-model="snackbar">{{ text }}
  <div style="margin-left: 40px">
    <v-btn
      :key="i"
      v-for="(btn, i) in btns"
      flat
      :color="btn.color"
      @click.native="callback(btn, $event)">{{ btn.text }}</v-btn>
  </div>
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
    btns: []
  }),
  
  created() {
    this.$bus.$on('show-snackbar', (text, options, btns) => {
      let hasValue = (val, prop) => typeof prop === 'undefined' ? val : prop
      this.text = text
      // default
      if (typeof options === 'undefined' || options === null) {
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

      if (typeof btns === 'undefined') {
        this.btns = []
        this.btns.push({
          color: 'accent',
          text: 'close',
          cb: (sb, e) => {
            sb.snackbar = false
          }
        })
      } else if (btns.constructor.name === 'Array') {
        this.btns = btns
      } else if (btns.constructor.name === 'Object') {
        this.btns = []
        this.btns.push(btns)
      }
      this.snackbar = true
    })
  },

  methods: {
    callback(btn, e) {
      if (typeof btn.cb === 'function') {
        btn.cb(this, e)
      }
    }
  }
}
</script>
