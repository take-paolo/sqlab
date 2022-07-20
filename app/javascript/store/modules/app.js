import router from '@/router/index'

const app = {
  namespaced: true,
  state: {
    sidebarWidth: 72,
    footerHeight: 0,
  },
  getters: {
    sidebarWidth: state => state.sidebarWidth,
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
