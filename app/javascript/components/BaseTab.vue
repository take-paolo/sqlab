<template>
  <v-tab
    class="base-tab"
    :ripple="{ center: true, class: 'primary--text' }"
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
  &:before {
    background: var(--v-primary-base);
  }
}
</style>
