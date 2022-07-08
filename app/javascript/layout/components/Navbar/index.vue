<template>
  <v-navigation-drawer
    class="app-navbar"
    app
    right
    permanent
    mini-variant
    :mini-variant-width="width"
    color="white"
    tag="div"
  >
    <template #prepend>
      <div class="app-navbar--prepend">
        <NavbarLogo />
      </div>
      <BaseDivider class="mx-3" />
    </template>

    <div class="my-4">
      <!-- default navigation -->
      <NavbarItem
        v-for="(navItem, index) in nav"
        :key="index"
        class="mb-4"
        :item="navItem"
        :disabled="navItem.disabled"
      />

      <!-- button for work drawer  -->
      <NavbarItem
        v-if="isPracticePage"
        :item="workDrawerBtn"
        @click="$listeners['toggle-work-drawer']"
      />
    </div>

    <template #append>
      <BaseDivider class="mx-3" />
      <div class="app-navbar--append">
        <!-- button for user drawer  -->
        <NavbarItem
          :item="userDrawerBtn"
          @click="$listeners['toggle-user-drawer']"
        />
      </div>
    </template>
  </v-navigation-drawer>
</template>

<script>
import nav from '@/data/nav'

import NavbarLogo from './components/NavbarLogo'
import NavbarItem from './components/NavbarItem'

export default {
  name: 'AppNavbar',
  components: {
    NavbarLogo,
    NavbarItem,
  },
  props: {
    width: {
      type: [String, Number],
      default: 56,
    },
    isPracticePage: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      nav: nav,
      workDrawerBtn: {
        id: 'work-drawer',
        icon: 'mdi-format-list-bulleted-square',
        tooltip: '問題一覧',
        disabled: false,
      },
      userDrawerBtn: {
        id: 'user-drawer',
        icon: 'mdi-account',
        tooltip: 'アカウント',
        disabled: false,
      },
    }
  },
}
</script>

<style lang="scss" scoped>
.app-navbar {
  z-index: 99;
}
.app-navbar--prepend,
.app-navbar--append {
  display: flex;
  align-items: center;
  justify-content: center;
}
.app-navbar--prepend {
  height: 72px;
}
.app-navbar--append {
  height: 56px;
}
</style>
