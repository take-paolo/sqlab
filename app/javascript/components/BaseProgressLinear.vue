<template>
  <v-progress-linear
    :value="value"
    :height="height"
    rounded
    background-color="grey lighten-3"
    v-bind="$attrs"
  >
    <span class="text-default">{{ value }}%</span>
  </v-progress-linear>
</template>

<script>
export default {
  name: 'BaseProgressLinear',
  inheritAttrs: false,
  props: {
    value: {
      type: [String, Number],
      default: 0,
    },
    height: {
      type: [String, Number],
      default: 25,
    },
  },
}
</script>
