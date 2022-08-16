import router from '@/router/index'

const app = {
  namespaced: true,
  state: {
    sidebarWidth: 72,
    adminSidebarWidth: 256,
    footerHeight: 0,
    flashMessageActive: false,
    flashMessageType: '',
    isVisibleLoginModal: false,
  },
  getters: {
    sidebarWidth: state => state.sidebarWidth,
    adminSidebarWidth: state => state.adminSidebarWidth,
    isPracticePage: () => router.app.$route.name === 'Practice',
    footerHeight: state => state.footerHeight,
    flashMessageActive: state => state.flashMessageActive,
    flashMessageType: state => state.flashMessageType,
    isVisibleLoginModal: state => state.isVisibleLoginModal,
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
    setLoginModal(state, isVisible) {
      state.isVisibleLoginModal = isVisible
    },
  },
  actions: {
    updateFooterHeight({ commit }, height) {
      commit('setFooterHeight', height)
    },
    openFlashMessage({ commit }, flashMessageType) {
      commit('setFlashMessage', flashMessageType)
    },
    switchLoginModal({ commit }, isVisible) {
      commit('setLoginModal', isVisible)
    },
  },
}

export default app
