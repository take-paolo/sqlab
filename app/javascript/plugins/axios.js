import axios from 'axios'

const host = {
  development: 'http://127.0.0.1:3000',
  staging: 'https://sqlab-staging.magia.runteq.jp',
  production: 'https://sqlab.net',
}

const axiosInstance = axios.create({
  baseURL: `${host[process.env.NODE_ENV]}/api`,
  credentials: true,
})

axiosInstance.interceptors.request.use(config => {
  if (['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }
  return config
})

export default axiosInstance
