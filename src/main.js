// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import axios from 'axios'
import routerCond from './assets/js/routerCond'

// css
import './assets/css/common.css'

const dev = true
const baseURL = dev ? 'http://localhost/xforge/public/ci' : 'to be set'
const http = axios.create({ baseURL: baseURL })

Vue.config.productionTip = false
Vue.prototype.$baseURL = baseURL
Vue.prototype.$http = http

routerCond(router, http)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
