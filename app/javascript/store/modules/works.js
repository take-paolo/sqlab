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
    updateBookmark(state, id) {
      state.work.chapters.forEach(chapter => {
        let practice = chapter.practices.find(practice => practice.id === id)
        practice.bookmarked = !practice.bookmarked
      })
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
    toggleBookmark({ commit }, id) {
      commit('updateBookmark', id)
    },
  },
}

export default works
