<template>
  <v-container
    class="base-container-admin"
    fluid
    v-bind="$attrs"
  >
    <slot />
  </v-container>
</template>

<script>
export default {
  name: 'BaseContainerAdmin',
  inheritAttrs: false,
}
</script>

<style lang="scss" scoped>
.base-container-admin {
  padding: 60px 10%;
  max-width: 1920px;
}
</style>
