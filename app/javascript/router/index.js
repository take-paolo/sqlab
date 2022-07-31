import Vue from 'vue'
import VueRouter from 'vue-router'

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
    path: '/admin',
    component: AdminLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/admin/dashboard/index'),
        name: 'AdminDashboard',
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

export default router
