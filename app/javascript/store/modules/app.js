import router from '@/router/index'

const app = {
  namespaced: true,
  state: {
    sidebarWidth: 72,
    adminSidebarWidth: 256,
    footerHeight: 0,
    flashMessageActive: false,
    flashMessageType: '',
  },
  getters: {
    sidebarWidth: state => state.sidebarWidth,
    adminSidebarWidth: state => state.adminSidebarWidth,
    isPracticePage: () => router.app.$route.name === 'Practice',
    footerHeight: state => state.footerHeight,
    flashMessageActive: state => state.flashMessageActive,
    flashMessageType: state => state.flashMessageType,
  },
  mutations: {
    setFooterHeight(state, height) {
      state.footerHeight = height
    },
    setFlashMessage(state, flashMessageType) {
      state.flashMessageType = flashMessageType
      state.flashMessageActive = true
      setTimeout(() => {
        state.flashMessageActive = false
      }, 3000)
    },
  },
  actions: {
    updateFooterHeight({ commit }, height) {
      commit('setFooterHeight', height)
    },
    openFlashMessage({ commit }, flashMessageType) {
      commit('setFlashMessage', flashMessageType)
    },
  },
}

export default app
