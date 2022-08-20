<template>
  <v-tab
    class="base-tab"
    :ripple="false"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-tab>
</template>

<script>
export default {
  name: 'BaseTab',
  inheritAttrs: false,
}
</script>

<style lang="scss" scoped>
.base-tab {
  height: 100%;
  &:before {
    background: var(--v-primary-base);
  }
}
</style>
