import Vue from 'vue'
import VueRouter from 'vue-router'

import Layout from '@/layout'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: Layout,
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
    component: Layout,
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
    component: Layout,
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
    component: Layout,
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
    component: Layout,
    children: [
      {
        path: '',
        component: () => import('@/views/terms/index'),
        name: 'Terms',
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
