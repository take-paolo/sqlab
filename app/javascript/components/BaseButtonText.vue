<template>
  <v-btn
    class="base-btn base-btn-text"
    text
    :color="color"
    :ripple="{ center: true, class: 'primary--text' }"
    link
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-btn>
</template>

<script>
export default {
  name: 'BaseButtonText',
  inheritAttrs: false,
  props: {
    color: {
      type: String,
      default: 'font',
    },
  },
}
</script>

<style lang="scss">
.base-btn-text {
  &:before {
    background: var(--v-primary-base);
  }
}
</style>
