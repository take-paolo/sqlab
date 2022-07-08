<template>
  <v-tooltip
    :activator="activator"
    :color="color"
    z-index="999"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <span>
      <slot />
    </span>
  </v-tooltip>
</template>

<script>
export default {
  name: 'BaseTooltip',
  inheritAttrs: false,
  props: {
    activator: {
      type: undefined,
      required: true,
    },
    color: {
      type: String,
      default: 'primary',
    },
  },
}
</script>
