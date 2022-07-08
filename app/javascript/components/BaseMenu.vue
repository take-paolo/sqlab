<template>
  <v-menu
    :activator="activator"
    open-on-hover
    content-class="base-menu"
    :close-delay="closeDelay"
    :transition="transition"
    :origin="origin"
    z-index="999"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-menu>
</template>

<script>
export default {
  name: 'BaseMenu',
  inheritAttrs: false,
  props: {
    activator: {
      type: undefined,
      required: true,
    },
    contentClass: {
      type: String,
      default: '',
    },
    closeDelay: {
      type: String,
      default: '150',
    },
    transition: {
      type: String,
      default: 'scale-transition',
    },
    origin: {
      type: String,
      default: 'center center',
    },
  },
}
</script>

<style lang="scss" scoped>
.base-menu {
  box-shadow: var(--shadow);
}
</style>
