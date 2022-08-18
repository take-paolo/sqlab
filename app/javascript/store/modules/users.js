import axios from '@/plugins/axios'

const users = {
  namespaced: true,
  state: {
    authUser: null,
  },
  getters: {
    authUser: state => state.authUser,
  },
  mutations: {
    setAuthUser(state, authUser) {
      state.authUser = authUser
    },
  },
  actions: {
    async logoutUser({ commit }) {
      await axios.delete('logout')
      commit('setAuthUser', null)
    },
    resetAuthUser({ commit }) {
      commit('setAuthUser', null)
    },
    getAuthUser({ state, dispatch }) {
      if (state.authUser) return state.authUser

      return dispatch('fetchAuthUser')
    },
    async fetchAuthUser({ commit }) {
      try {
        const response = await axios.get('auth_user')
        commit('setAuthUser', response.data)
        return response.data
      } catch {
        return null
      }
    },
  },
}

export default users
