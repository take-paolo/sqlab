<template>
  <v-container
    class="app-container"
    fluid
    v-bind="$attrs"
  >
    <slot />
  </v-container>
</template>

<script>
export default {
  name: 'AppContainer',
  inheritAttrs: false,
}
</script>

<style lang="scss" scoped>
.app-container {
  padding: 40px 2% 80px;
  max-width: 1672px;
}
</style>
