<template>
  <v-subheader class="user-drawer-menu__category">
    <BaseIcon
      dense
      color="primary"
    >
      mdi-rhombus-medium
    </BaseIcon>
    <span class="font--text">
      <slot />
    </span>
  </v-subheader>
</template>

<script>
export default {
  name: 'UserDrawerMenuCategory',
  props: {
    title: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.user-drawer-menu__category {
  padding: 0;
  font-size: 0.75rem;
  height: 40px;
}
</style>
