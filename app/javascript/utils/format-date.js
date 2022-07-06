import dayjs from 'dayjs'

dayjs.locale('ja')

export function formatDate(date) {
  return dayjs(date).format('YYYY/MM/DD, HH:mm')
}
