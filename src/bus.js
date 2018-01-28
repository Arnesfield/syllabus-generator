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
      suggestions: true
    }
  })
})
