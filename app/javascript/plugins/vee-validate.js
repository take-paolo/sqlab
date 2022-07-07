import Vue from 'vue'
import { ValidationProvider, ValidationObserver, extend, localize } from 'vee-validate'
import ja from 'vee-validate/dist/locale/ja.json'
import { required } from 'vee-validate/dist/rules'

localize('ja', ja)

extend('required', {
  ...required,
})

Vue.component('ValidationProvider', ValidationProvider)
Vue.component('ValidationObserver', ValidationObserver)
