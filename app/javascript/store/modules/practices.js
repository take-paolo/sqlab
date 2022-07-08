import axios from '@/plugins/axios'
import { handleException } from '@/utils/exception'

const practices = {
  namespaced: true,
  state: {
    practice: null,
  },
  getters: {
    practice: state => state.practice,
  },
  mutations: {
    setPractice(state, practice) {
      state.practice = practice
    },
  },
  actions: {
    async fetchPractice({ commit }, id) {
      await axios
        .get(`practices/${id}`)
        .then(res => commit('setPractice', res.data))
        .catch(err => handleException(err))
    },
  },
}

export default practices
