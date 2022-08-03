<template>
  <v-container
    class="app-container-admin"
    fluid
    v-bind="$attrs"
  >
    <slot />
  </v-container>
</template>

<script>
export default {
  name: 'AppContainerAdmin',
  inheritAttrs: false,
}
</script>

<style lang="scss" scoped>
.app-container-admin {
  padding: 60px 10%;
  max-width: 1920px;
}
</style>
