const font = Object.freeze({
  base: '#5A6977',
  lighten1: '#757680',
  darken1: '#252545',
})
const primary = Object.freeze({
  base: '#7F96FC',
  lighten5: '#F5F6FC',
  lighten4: '#E8ECFC',
  lighten3: '#CFD7FC',
  lighten2: '#B4C6FF',
  lighten1: '#A3B7FF',
  darken1: '#617BED',
  darken2: '#4968C8',
  darken3: '#24439E',
  darken4: '#173180',
})
const accent = Object.freeze({
  base: '#FBC02D',
  lighten1: '#FFF263',
  darken1: '#C49000',
})

export default {
  font: {
    base: font.base,
    lighten1: font.lighten1,
    darken1: font.darken1,
  },
  primary: {
    base: primary.base,
    lighten5: primary.lighten5,
    lighten4: primary.lighten4,
    lighten3: primary.lighten3,
    lighten2: primary.lighten2,
    lighten1: primary.lighten1,
    darken1: primary.darken1,
    darken2: primary.darken2,
    darken3: primary.darken3,
    darken4: primary.darken4,
  },
  accent: {
    base: accent.base,
    lighten1: accent.lighten1,
    darken1: accent.darken1,
  },
}
