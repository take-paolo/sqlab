<template>
  <v-list-item
    class="admin-navbar-item"
    color="white"
    exact
    :input-value="$route.name === item.to.name"
    :to="item.to"
    :ripple="false"
    v-bind="$attrs"
  >
    <v-list-item-icon>
      <BaseIcon color="white">
        {{ item.icon }}
      </BaseIcon>
    </v-list-item-icon>
    <v-list-item-title class="text-small white--text">
      {{ item.title }}
    </v-list-item-title>
  </v-list-item>
</template>

<script>
export default {
  name: 'AdminNavbarItem',
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.admin-navbar-item {
  &.v-list-item {
    padding: 0 24px;

    &:before {
      background: white;
    }
  }
  .v-list-item__icon {
    align-self: center;
    margin: 0;

    &:first-child {
      margin-right: 24px;
    }
  }
}
</style>
