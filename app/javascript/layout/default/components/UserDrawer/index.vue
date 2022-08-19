<template>
  <BaseDrawer
    class="default-user-drawer"
    :is-active="isActive"
    app
    right
    @update:isActive="$listeners['update:isActive']"
  >
    <UserDrawerHeading :user="authUser" />

    <div class="py-3 pl-5">
      <v-subheader class="default-user-drawer-menu__category">
        <BaseIcon
          dense
          color="primary"
        >
          mdi-rhombus-medium
        </BaseIcon>
        <span class="font--text">メニュー</span>
      </v-subheader>

      <v-list dense>
        <v-list-item
          class="rounded-l-xl overflow-hidden px-4"
          :to="{ name: 'Mypage' }"
          color="primary"
          :ripple="false"
        >
          <v-list-item-icon class="mr-2">
            <BaseIcon
              dense
              color="inherit"
            >
              mdi-account
            </BaseIcon>
          </v-list-item-icon>
          <v-list-item-title class="font-weight-medium">マイページ </v-list-item-title>
        </v-list-item>

        <v-list-item
          class="rounded-l-xl overflow-hidden px-4"
          color="primary"
          :ripple="false"
          @click.stop="$emit('logout')"
        >
          <v-list-item-icon class="mr-2">
            <BaseIcon
              dense
              color="inherit"
            >
              mdi-logout
            </BaseIcon>
          </v-list-item-icon>
          <v-list-item-title class="font-weight-medium">ログアウト</v-list-item-title>
        </v-list-item>
      </v-list>
    </div>
  </BaseDrawer>
</template>

<script>
import { mapGetters } from 'vuex'

import UserDrawerHeading from './components/UserDrawerHeading'

export default {
  name: 'UserDrawer',
  components: {
    UserDrawerHeading,
  },
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
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
.default-user-drawer-menu__category {
  padding: 0;
  font-size: 0.75rem;
  height: 40px;
}
</style>
