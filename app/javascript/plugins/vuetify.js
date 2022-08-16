import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import light from './vuetify/theme'

Vue.use(Vuetify)

const options = {
  theme: {
    themes: {
      light,
    },
    options: {
      customProperties: true,
    },
  },
}

export default new Vuetify(options)
