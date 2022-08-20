<template>
  <div class="d-flex justify-center">
    <router-link
      class="app-logo-link"
      :to="{ name: 'Top' }"
    >
      <AppLogo
        :width="width"
        :height="height"
        :dark="dark"
      />
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'AppLogoLink',
  inheritAttrs: false,
  props: {
    width: {
      type: String,
      default: '88px',
    },
    height: {
      type: String,
      default: '26px',
    },
    dark: {
      type: Boolean,
      default: false,
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
