import Vue from 'vue'
import Router from 'vue-router'

import Home from '@/components/Home'
import Login from '@/components/Login'
import Dashboard from '@/components/Dashboard'
import Generator from '@/components/Generator'
import Assignments from '@/components/Assignments'
import Reviews from '@/components/Reviews'
import Workflow from '@/components/Workflow'
import Syllabus from '@/components/Syllabus'

import ManageUsers from '@/components/manage/ManageUsers'
import ManageCourses from '@/components/manage/ManageCourses'
import ManageBooks from '@/components/manage/ManageBooks'
import ManageCurriculum from '@/components/manage/ManageCurriculum'

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
        auth: [3, 4, 5],
        icon: 'dashboard'
      }
    },
    {
      path: '/generator/:assignId',
      name: 'Generator',
      component: Generator,
      props: true,
      meta: {
        auth: [3, 4],
        icon: 'build'
      }
    },
    {
      path: '/assignments',
      name: 'Assignments',
      component: Assignments,
      meta: {
        auth: 3,
        icon: 'assignment'
      }
    },
    {
      path: '/reviews',
      name: 'Reviews',
      component: Reviews,
      meta: {
        auth: 5,
        icon: 'rate_review'
      }
    },
    {
      path: '/workflow',
      name: 'Workflow',
      component: Workflow,
      meta: {
        auth: [4],
        icon: 'supervisor_account'
      }
    },
    {
      path: '/syllabus/:assignId',
      name: 'Syllabus',
      component: Syllabus,
      props: true,
      meta: {
        auth: [3, 4, 5],
        icon: 'subject'
      }
    },

    // manage

    {
      path: '/manage/users',
      name: 'ManageUsers',
      component: ManageUsers,
      meta: {
        auth: 1,
        title: 'Manage Users',
        icon: 'account_circle'
      }
    },
    {
      path: '/manage/courses',
      name: 'ManageCourses',
      component: ManageCourses,
      meta: {
        auth: 1,
        title: 'Manage Courses',
        icon: 'school'
      }
    },
    {
      path: '/manage/books',
      name: 'ManageBooks',
      component: ManageBooks,
      meta: {
        auth: [1, 6],
        title: 'Manage Books',
        icon: 'library_books'
      }
    },
    {
      path: '/manage/curriculum',
      name: 'ManageCurriculum',
      component: ManageCurriculum,
      meta: {
        auth: 1,
        title: 'Manage Curriculum',
        icon: 'description'
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
        auth: -1
      }
    }
  ]
})
