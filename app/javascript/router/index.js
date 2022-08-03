import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '@/store/index'

import DefaultLayout from '@/layout/default'
import AdminLayout from '@/layout/admin'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/top/index'),
        name: 'Top',
      },
    ],
  },
  {
    path: '/works',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/works/index'),
        name: 'Works',
      },
    ],
  },
  {
    path: '/works/:slug',
    component: DefaultLayout,
    children: [
      {
        path: '',
        name: 'Work',
        component: () => import('@/views/work/index'),
      },
    ],
  },
  {
    path: '/works/:slug/:id',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/practice/index'),
        name: 'Practice',
      },
    ],
  },
  {
    path: '/terms',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/terms/index'),
        name: 'Terms',
      },
    ],
  },
  {
    path: '/privacy',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/privacy/index'),
        name: 'Privacy',
      },
    ],
  },
  {
    path: '/admin/login',
    component: () => import('@/views/admin/login/index'),
    name: 'AdminLogin',
  },
  {
    path: '/admin',
    component: AdminLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/admin/dashboard/index'),
        name: 'AdminDashboard',
        meta: { requiresAuth: true },
        beforeEnter: checkAdmin,
      },
    ],
  },
  {
    path: '/admin/works',
    component: AdminLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/admin/works/index'),
        name: 'AdminWorks',
        meta: { requiresAuth: true },
        beforeEnter: checkAdmin,
      },
    ],
  },
  {
    path: '/admin/users',
    component: AdminLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/admin/users/index'),
        name: 'AdminUsers',
        meta: { requiresAuth: true },
        beforeEnter: checkAdmin,
      },
    ],
  },
  {
    path: '*',
    component: () => import('@/views/errors/404'),
    name: 'PageNotFound',
  },
  {
    path: '*',
    component: () => import('@/views/errors/500'),
    name: 'InternalServerError',
  },
]

const router = new VueRouter({
  mode: 'history',
  routes,
})

router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser').then(authUser => {
    if (to.matched.some(record => record.meta.requiresAuth) && !authUser) {
      next({ name: 'AdminLogin' })
    } else {
      next()
    }
  })
})

function checkAdmin(to, from, next) {
  const authUser = store.getters['users/authUser']
  if (authUser.role === 'admin') {
    next()
  } else {
    next({ name: 'Top' })
  }
}

export default router
