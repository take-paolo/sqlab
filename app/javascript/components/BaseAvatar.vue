<template>
  <v-avatar
    class="d-block text-center mx-auto"
    :color="color"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-avatar>
</template>

<script>
export default {
  name: 'BaseAvatar',
  inheritAttrs: false,
  props: {
    color: {
      type: String,
      default: 'primary',
    },
  },
}
</script>
