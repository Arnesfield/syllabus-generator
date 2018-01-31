import Vue from 'vue'

export default new Vue({
  data: () => ({
    // all
    user: null,
    // toolbar
    drawer: null,
    tab: null,
    tabs: null,
    tabItems: null,
    menu: null,
    // generator
    generator: {
      suggestions: true,
      warn: true
    }
  }),

  watch: {
    'generator.suggestions': function(to, from) {
      if (to == false && this.generator.warn == false) {
        this.generator.warn = true
      }
      this.$emit('on-bus-generator-suggestion-change')
    }
  }
})
