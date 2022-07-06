import Vue from 'vue'
import VueRouter from 'vue-router'

import TopIndex from '@/pages/top/index.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: TopIndex, name: 'TopIndex' }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
