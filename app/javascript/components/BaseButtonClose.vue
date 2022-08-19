<template>
  <v-btn
    class="base-btn base-btn-icon base-btn-close"
    icon
    :ripple="false"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <BaseIcon>mdi-close</BaseIcon>
  </v-btn>
</template>

<script>
export default {
  name: 'BaseButtonClose',
  inheritAttrs: false,
}
</script>

<style lang="scss" scoped>
.base-btn-close {
  position: absolute;
  top: 10px;
  right: 10px;
}
</style>
