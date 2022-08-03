import Vue from 'vue'
import Vuex from 'vuex'

import app from './modules/app'
import works from './modules/works'
import practices from './modules/practices'
import users from './modules/users'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    app,
    works,
    practices,
    users,
  },
})

export default store
