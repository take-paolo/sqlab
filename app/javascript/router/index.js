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
        component: () => import('@/views/work/index'),
        name: 'Work',
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
    path: '/mypage',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/mypage/index'),
        name: 'Mypage',
        beforeEnter: checkAuth,
      },
    ],
  },
  {
    path: '/login',
    component: DefaultLayout,
    children: [
      {
        path: '',
        component: () => import('@/views/login/index'),
        name: 'Login',
        beforeEnter: checkLoggedIn,
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
        beforeEnter: checkAdminAuth,
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
        beforeEnter: checkAdminAuth,
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
        beforeEnter: checkAdminAuth,
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
  redirectToPath(next)
})

function redirectToPath(next) {
  if (!localStorage.redirectPath) return next()

  const path = localStorage.redirectPath
  localStorage.redirectPath = ''

  store.dispatch('users/fetchAuthUser').then(authUser => {
    next({ path: path })
    if (authUser) {
      store.dispatch('app/openFlashMessage', 'loginSuccess')
    } else {
      store.dispatch('app/openFlashMessage', 'loginFail')
    }
  })
}

function checkAuth(to, from, next) {
  store.dispatch('users/fetchAuthUser').then(authUser => {
    if (authUser) {
      next()
    } else {
      next({ name: 'Login' })
      store.dispatch('app/openFlashMessage', 'loginWarning')
    }
  })
}

function checkLoggedIn(to, from, next) {
  const authUser = store.getters['users/authUser']

  if (authUser) {
    next({ name: 'Top' })
  } else {
    next()
  }
}

function checkAdminAuth(to, from, next) {
  const authUser = store.getters['users/authUser']

  if (authUser?.role === 'admin') {
    next()
  } else {
    next({ name: 'Top' })
  }
}

export default router
