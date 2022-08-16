import router from '@/router/index'

export function handleException(err, path = '') {
  path = path || router.history._startLocation

  if (err.response?.status === 404) {
    router.push({ name: 'PageNotFound', params: { 0: path } })
  } else if (err.response?.status === 401) {
    router.push({ name: 'Login' })
  } else {
    router.push({ name: 'InternalServerError', params: { 0: path } })
  }
}
