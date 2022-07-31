<template>
  <BaseButton
    class="works-footer-btn px-4"
    :color="color"
    rounded
    depressed
    v-bind="$attrs"
    v-on="$listeners"
  >
    <BaseIcon
      left
      color="inherit"
    >
      {{ icon }}
    </BaseIcon>
    <slot />
  </BaseButton>
</template>

<script>
export default {
  name: 'WorksFooterButton',
  props: {
    color: {
      type: String,
      default: 'primary lighten-4 primary--text',
    },
    icon: {
      type: String,
      default: 'mdi-plus',
    },
  },
}
</script>

<style lang="scss" scoped>
.works-footer-btn {
  &:not(:first-child) {
    margin-left: 0.5rem;
  }
}
</style>
