<template>
  <v-btn
    class="base-btn"
    :color="color"
    :ripple="{ center: true }"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-btn>
</template>

<script>
export default {
  name: 'BaseButton',
  inheritAttrs: false,
  props: {
    color: {
      type: String,
      default: 'primary',
    },
  },
}
</script>

<style lang="scss">
.base-btn {
  &:before {
    opacity: 0 !important;
  }
  &:hover,
  &:focus {
    &:before {
      opacity: 0.18 !important;
    }
  }
}
</style>
