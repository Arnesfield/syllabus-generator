import Vue from 'vue'
import Router from 'vue-router'
import Components from '@/components'

Vue.use(Router)

const router = new Router({
  routes: [
    {
      path: '/login',
      name: 'Login',
      component: Components.Login,
      meta: {
        title: 'Login',
        auth: false
      }
    },

    {
      path: '/',
      name: 'Home',
      component: Components.Home,
      meta: {
        title: 'Home'
      }
    },

    // last resort
    {
      path: '*',
      name: 'NotFound',
      component: Components.NotFound,
      meta: {
        title: 'Page not found',
        auth: null
      }
    }
  ]
})

export default router
