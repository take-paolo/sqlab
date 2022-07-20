import Vue from 'vue'
import Vuex from 'vuex'

import app from './modules/app'
import works from './modules/works'
import practices from './modules/practices'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    app,
    works,
    practices,
  },
})

export default store
