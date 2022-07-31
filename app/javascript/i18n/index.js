import Vue from 'vue'
import VueI18n from 'vue-i18n'

// messages
import ja from './messages/ja'

Vue.use(VueI18n)

const i18n = new VueI18n({
  locale: 'ja',
  messages: { ja },
})

export default i18n
