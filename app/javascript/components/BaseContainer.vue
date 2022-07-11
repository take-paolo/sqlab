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
  padding: 0 2%;
  max-width: 1672px;
}
</style>
