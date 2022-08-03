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
    async loginUser({ commit }, user) {
      const sessionsResponse = await axios.post('sessions', user)
      localStorage.auth_token = sessionsResponse.data.token
      axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`

      const userResponce = await axios.get('auth_user')
      commit('setAuthUser', userResponce.data)
    },
    logoutUser({ commit }) {
      localStorage.auth_token = ''
      axios.defaults.headers.common['Authorization'] = ''
      commit('setAuthUser', null)
    },
    async fetchAuthUser({ commit, state }) {
      if (!localStorage.auth_token) return null
      if (state.authUser) return state.authUser

      const userResponce = await axios.get('auth_user').catch(() => null)
      const authUser = userResponce.data
      if (authUser) {
        commit('setAuthUser', authUser)
        return authUser
      } else {
        commit('setAuthUser', null)
        return null
      }
    },
  },
}

export default users
