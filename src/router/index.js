import Vue from 'vue'
import Router from 'vue-router'
import Components from '@/components'

Vue.use(Router)

const router = new Router({
  scrollBehavior(to, from, savedPosition) {
    if (to.hash) {
      return {
        selector: to.hash
        // , offset: { x: 0, y: 10 }
      }
    }
    return savedPosition ? savedPosition : { x: 0, y: 0 }
  },

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
        title: 'Home',
        auth: false
      }
    },

    {
      path: '/dashboard',
      component: Components.Dashboard,

      children: [
        {
          path: '',
          name: 'Activities',
          component: Components.Activities,
          meta: {
            title: 'Dashboard'
          }
        },
        {
          path: '/syllabi',
          name: 'Syllabi',
          component: Components.Syllabi,
          meta: {
            title: 'Syllabi'
          }
        },
        {
          path: '/generator',
          name: 'Generator',
          component: Components.Generator,
          meta: {
            title: 'Generator'
          }
        },
        {
          path: '/manage',
          component: Components.Manage,
    
          children: [
            {
              path: '/manage/users',
              name: 'Manage Users',
              component: Components.ManageUsers,
              meta: {
                title: 'Manage Users'
              }
            },
          ]
        }
      ]
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
