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
    async fetchAuthUser({ commit, state }) {
      if (state.authUser) return state.authUser

      await axios
        .get('auth_user')
        .then(res => commit('setAuthUser', res.data))
        .catch(() => null)

      return state.authUser
    },
  },
}

export default users
