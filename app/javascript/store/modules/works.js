import axios from '@/plugins/axios'
import { handleException } from '@/utils/exception'

function calcWorkChapters(work) {
  return work.chapters.length
}
function calcWorkPractices(work) {
  let totalPractices = 0
  work.chapters.forEach(chapter => (totalPractices += chapter.practices.length))
  return totalPractices
}

const works = {
  namespaced: true,
  state: {
    work: null,
    totalChapters: null,
    totalPractices: null,
  },
  getters: {
    work: state => state.work,
  },
  mutations: {
    setWork(state, work) {
      state.work = work
      state.work.totalChapters = calcWorkChapters(work)
      state.work.totalPractices = calcWorkPractices(work)
    },
  },
  actions: {
    async fetchWork({ state, commit }, slug) {
      if (state.work === null || state.work.slug != slug) {
        axios
          .get(`works/${slug}`)
          .then(res => commit('setWork', res.data))
          .catch(err => handleException(err))
      }
    },
  },
}

export default works
