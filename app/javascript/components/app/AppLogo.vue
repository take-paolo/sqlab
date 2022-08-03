<template>
  <div class="d-flex justify-center">
    <router-link
      class="app-logo-link"
      :to="{ name: 'Top' }"
    >
      <BaseImage
        :max-width="width"
        eager
        :src="require(`@/assets/${logoType}.svg`)"
        alt="SQLab"
      />
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'AppLogo',
  inheritAttrs: false,
  props: {
    width: {
      type: String,
      default: '88px',
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

<style lang="scss" scoped>
.app-logo-link {
  &:hover {
    opacity: 0.5;
    transition: 0.3s cubic-bezier(0.25, 0.8, 0.5, 1);
  }
}
</style>
