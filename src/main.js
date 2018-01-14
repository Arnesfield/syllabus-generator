// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import axios from 'axios'
import Vuetify from 'vuetify'

// helpers
import routerCond from './assets/js/routerCond'
import colors from 'vuetify/es5/util/colors'

// css
import 'vuetify/dist/vuetify.min.css'
import './assets/css/common.css'

const dev = true
const baseURL = dev ? 'http://localhost/school/thesisx/web/public/ci' : 'to be set'
const http = axios.create({ baseURL: baseURL })

Vue.config.productionTip = false
Vue.prototype.$baseURL = baseURL
Vue.prototype.$http = http

routerCond(router, http)

Vue.use(Vuetify, {
  theme: {
    primary: colors.indigo.base,
    secondary: colors.indigo.lighten4,
    accent: colors.pink.accent2
  }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
