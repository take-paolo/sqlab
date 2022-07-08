<template>
  <v-icon
    :color="color"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-icon>
</template>

<script>
export default {
  name: 'BaseIcon',
  inheritAttrs: false,
  props: {
    color: {
      type: String,
      default: 'font',
    },
  },
}
</script>
