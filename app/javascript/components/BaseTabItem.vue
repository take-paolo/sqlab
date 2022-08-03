<template>
  <v-tab-item
    :transition="transition"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-tab-item>
</template>

<script>
export default {
  name: 'BaseTabItem',
  inheritAttrs: false,
  props: {
    transition: {
      type: [Boolean, String],
      default: false,
    },
  },
}
</script>
