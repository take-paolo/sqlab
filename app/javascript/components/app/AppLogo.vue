<template>
  <img
    class="d-block mx-auto"
    :src="require(`@/assets/${logoType}.svg`)"
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
    logoType() {
      return this.dark ? 'logo-dark' : 'logo'
    },
  },
}
</script>
