import axios from 'axios'

const production = 'https://sqlabapp.herokuapp.com'
const development = 'http://127.0.0.1:3000'
const url = process.env.NODE_ENV === 'production' ? production : development

const axiosInstance = axios.create({ baseURL: `${url}/api` })

if (localStorage.auth_token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
}

export default axiosInstance
