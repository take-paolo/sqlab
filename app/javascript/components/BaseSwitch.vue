<template>
  <v-switch
    class="base-switch ma-0 pa-0"
    :input-value="inputValue"
    :label="label"
    :messages="messages"
    :color="color"
    inset
    hide-details="auto"
    v-bind="$attrs"
    v-on="$listeners"
  />
</template>

<script>
export default {
  name: 'BaseSwitch',
  inheritAttrs: false,
  props: {
    inputValue: {
      type: Boolean,
      required: true,
    },
    label: {
      type: String,
      default: '',
    },
    messages: {
      type: String,
      default: '',
    },
    color: {
      type: String,
      default: 'primary',
    },
  },
}
</script>

<style lang="scss">
.base-switch {
  .v-input__slot {
    width: max-content;
  }
}
</style>
