<template>
  <BaseDrawer
    class="default-user-drawer"
    :is-active="isActive"
    app
    right
    @update:isActive="$listeners['update:isActive']"
  >
    <UserDrawerHeading :user="authUser" />

    <div class="py-2 pl-4">
      <div
        v-for="(userMenu, index) in userMenuList"
        :key="index"
      >
        <UserDrawerMenuCategory>
          {{ userMenu.category }}
        </UserDrawerMenuCategory>
        <UserDrawerMenuList :items="userMenu.items" />
      </div>
    </div>

    <div class="default-user-drawer-logout-btn-wrap">
      <BaseButton
        outlined
        width="100%"
        height="44px"
        color="primary"
        @click.stop="$emit('logout')"
      >
        <BaseIcon
          left
          color="inherit"
        >
          mdi-logout
        </BaseIcon>
        ログアウト
      </BaseButton>
    </div>
  </BaseDrawer>
</template>

<script>
import { mapGetters } from 'vuex'

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
  computed: {
    ...mapGetters('users', ['authUser']),
  },
}
</script>

<style lang="scss" scoped>
.default-user-drawer {
  max-width: 324px;
}
.default-user-drawer-logout-btn-wrap {
  position: fixed;
  bottom: 0;
  left: 0;
  padding: 1rem;
  width: 100%;
}
</style>
