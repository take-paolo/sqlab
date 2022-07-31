import router from '@/router/index'

const app = {
  namespaced: true,
  state: {
    sidebarWidth: 72,
    adminSidebarWidth: 256,
    footerHeight: 0,
  },
  getters: {
    sidebarWidth: state => state.sidebarWidth,
    adminSidebarWidth: state => state.adminSidebarWidth,
    isPracticePage: () => router.app.$route.name === 'Practice',
    footerHeight: state => state.footerHeight,
  },
  mutations: {
    setFooterHeight(state, height) {
      state.footerHeight = height
    },
  },
  actions: {
    updateFooterHeight({ commit }, height) {
      commit('setFooterHeight', height)
    },
  },
}

export default app
