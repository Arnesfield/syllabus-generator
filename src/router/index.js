import Vue from 'vue'
import Router from 'vue-router'

import Home from '@/components/Home'
import Login from '@/components/Login'
import Dashboard from '@/components/Dashboard'
import Generator from '@/components/Generator'
import Assignments from '@/components/Assignments'
import Assign from '@/components/Assign'

import ManageUsers from '@/components/manage/ManageUsers'
import ManageCourses from '@/components/manage/ManageCourses'
import ManageBooks from '@/components/manage/ManageBooks'

import NotFound from '@/components/errors/NotFound'

Vue.use(Router)

export default new Router({
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
    // auth 0
    {
      path: '/',
      name: 'Home',
      component: Home,
      meta: {
        auth: 0
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: {
        auth: 0
      }
    },
    // auth 3
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard,
      meta: {
        auth: 4,
        icon: 'dashboard'
      }
    },
    {
      path: '/generator/:assignId?',
      name: 'Generator',
      component: Generator,
      props: true,
      meta: {
        auth: 4,
        icon: 'build'
      }
    },
    {
      path: '/assignments',
      name: 'Assignments',
      component: Assignments,
      meta: {
        auth: 4,
        icon: 'assignment'
      }
    },
    {
      path: '/assign',
      name: 'Assign',
      component: Assign,
      meta: {
        auth: 3,
        icon: 'supervisor_account'
      }
    },

    // manage

    {
      path: '/manage/users',
      name: 'ManageUsers',
      component: ManageUsers,
      meta: {
        auth: 3,
        title: 'Manage Users',
        icon: 'account_circle'
      }
    },
    {
      path: '/manage/courses',
      name: 'ManageCourses',
      component: ManageCourses,
      meta: {
        auth: 3,
        title: 'Manage Courses',
        icon: 'school'
      }
    },
    {
      path: '/manage/books',
      name: 'ManageBooks',
      component: ManageBooks,
      meta: {
        auth: 3,
        title: 'Manage Books',
        icon: 'library_books'
      }
    },

    // end of manage

    // last resort
    {
      path: '*',
      name: 'NotFound',
      component: NotFound,
      meta: {
        title: 'Error 404',
        auth: 10
      }
    }
  ]
})
