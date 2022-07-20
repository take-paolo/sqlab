<template>
  <v-container
    class="base-container"
    fluid
    v-bind="$attrs"
  >
    <slot />
  </v-container>
</template>

<script>
export default {
  name: 'BaseContainer',
  inheritAttrs: false,
}
</script>

<style lang="scss" scoped>
.base-container {
  padding: 40px 2% 80px;
  max-width: 1672px;
}
</style>
