import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import light from './vuetify/theme'
import '@mdi/font/css/materialdesignicons.min.css'

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
  icons: {
    iconfont: 'mdi',
  },
}

export default new Vuetify(options)
