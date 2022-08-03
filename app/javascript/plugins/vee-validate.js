import Vue from 'vue'
import { ValidationProvider, ValidationObserver, extend, localize } from 'vee-validate'
import ja from 'vee-validate/dist/locale/ja.json'
import { required, regex, email, min, max } from 'vee-validate/dist/rules'

localize('ja', ja)

extend('required', {
  ...required,
})
extend('regex', {
  ...regex,
})
extend('email', {
  ...email,
  message: '{_field_}の形式で入力してください',
})
extend('min', {
  ...min,
  validate(value, { length }) {
    return value.length >= length
  },
  params: ['length'],
  message: '{_field_}は{length}文字以上で入力してください',
})
extend('max', {
  ...max,
  validate(value, { length }) {
    return value.length <= length
  },
  params: ['length'],
  message: '{_field_}は{length}文字以下で入力してください',
})
extend('password_confirmed', {
  params: ['target'],
  validate(value, { target }) {
    return value === target
  },
  message: 'パスワードと一致しません',
})

Vue.component('ValidationProvider', ValidationProvider)
Vue.component('ValidationObserver', ValidationObserver)
