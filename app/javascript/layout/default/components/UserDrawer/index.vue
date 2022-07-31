<template>
  <BaseDrawer
    class="default-user-drawer"
    :is-active="isActive"
    app
    right
    @update:isActive="$listeners['update:isActive']"
  >
    <UserDrawerHeading />

    <div class="py-2 pl-4">
      <div
        v-for="(userMenu, index) in userMenuList"
        :key="index"
      >
        <UserDrawerMenuCategory :title="userMenu.category" />
        <UserDrawerMenuList :items="userMenu.items" />
      </div>
    </div>
  </BaseDrawer>
</template>

<script>
import userMenu from '@/data/user-menu'

import UserDrawerHeading from './components/UserDrawerHeading'
import UserDrawerMenuCategory from './components/UserDrawerMenuCategory'
import UserDrawerMenuList from './components/UserDrawerMenuList'

export default {
  name: 'UserDrawer',
  components: {
    UserDrawerHeading,
    UserDrawerMenuCategory,
    UserDrawerMenuList,
  },
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      userMenuList: userMenu,
    }
  },
}
</script>

<style lang="scss" scoped>
.default-user-drawer {
  max-width: 324px;
}
</style>
