<template>
  <img
    class="d-block mx-auto"
    :src="logoSrc"
    alt="SQLab"
    :style="{
      width: width,
      maxWidth: width,
      height: height,
      maxHeight: height,
    }"
  />
</template>

<script>
import logoSvg from '@/assets/logo.svg'
import logoDarkSvg from '@/assets/logo-dark.svg'

export default {
  name: 'AppLogo',
  inheritAttrs: false,
  props: {
    width: {
      type: String,
      default: '98px',
    },
    height: {
      type: String,
      default: '30px',
    },
    dark: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    logoSrc() {
      return this.dark ? logoDarkSvg : logoSvg
    },
  },
}
</script>
