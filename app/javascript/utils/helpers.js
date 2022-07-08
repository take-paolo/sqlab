export function zeroPadding(num) {
  if (!isNumber(num)) return num
  return num.toString().padStart(2, '0')
}

export function toPixel(val) {
  return parseInt(val) + 'px'
}

export function isNumber(val) {
  return typeof val === 'number'
}

export function isString(val) {
  return typeof val === 'string'
}

export function isEmpty(obj) {
  return [Object, Array].includes((obj || {}).constructor) && !Object.entries(obj || {}).length
}

export function anchorTag(val) {
  return '#' + val
}

export function camelCase(str) {
  if (!isString) return str

  const strs = str.split(/[-_ ]+/)
  const length = strs.length

  if (length <= 1) return str

  str = strs[0].toLowerCase()

  for (let i = 1; i < length; i++) {
    str += strs[i].toLowerCase().replace(/^[a-z]/, function (val) {
      return val.toUpperCase()
    })
  }

  return str
}
