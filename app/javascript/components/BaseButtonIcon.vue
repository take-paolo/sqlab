<template>
  <v-btn
    class="base-btn base-btn-icon"
    icon
    :color="color"
    :ripple="ripple"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-btn>
</template>

<script>
export default {
  name: 'BaseButtonIcon',
  inheritAttrs: false,
  props: {
    color: {
      type: String,
      default: 'font',
    },
    ripple: {
      type: [Boolean, Object],
      default: () => ({ center: true, class: 'primary--text' }),
    },
  },
}
</script>

<style lang="scss">
.base-btn-icon {
  &:before {
    background: var(--v-primary-base);
  }
}
</style>
