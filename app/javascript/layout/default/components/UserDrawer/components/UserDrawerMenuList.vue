<template>
  <v-list dense>
    <UserDrawerMenuListItem
      v-for="(item, index) in items"
      :key="index"
      :item="item"
    />
  </v-list>
</template>

<script>
import UserDrawerMenuListItem from './UserDrawerMenuListItem'

export default {
  name: 'UserDrawerMenuList',
  components: {
    UserDrawerMenuListItem,
  },
  props: {
    items: {
      type: Array,
      default: () => [],
    },
  },
}
</script>
