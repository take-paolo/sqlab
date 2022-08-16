import axios from 'axios'

const production = 'https://sqlab.net'
const development = 'http://127.0.0.1:3000'
const url = process.env.NODE_ENV === 'production' ? production : development

const axiosInstance = axios.create({
  baseURL: `${url}/api`,
  credentials: true,
})

axiosInstance.interceptors.request.use(config => {
  if (['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }
  return config
})

export default axiosInstance
