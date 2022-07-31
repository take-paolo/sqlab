<template>
  <v-navigation-drawer
    class="default-navbar"
    app
    right
    permanent
    mini-variant
    :mini-variant-width="width"
    color="white"
    tag="div"
  >
    <template #prepend>
      <div class="default-navbar--prepend">
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
      <div class="default-navbar--append">
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
  name: 'DefaultNavbar',
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
        tooltip: '練習問題一覧',
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
.default-navbar {
  z-index: 99;
}
.default-navbar--prepend,
.default-navbar--append {
  display: flex;
  align-items: center;
  justify-content: center;
}
.default-navbar--prepend {
  height: 72px;
}
.default-navbar--append {
  height: 56px;
}
</style>
