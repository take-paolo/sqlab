<template>
  <v-navigation-drawer
    class="admin-navbar"
    app
    left
    permanent
    :width="width"
  >
    <template #prepend>
      <div class="admin-navbar--prepend">
        <AppLogoLink />
      </div>
    </template>

    <v-list
      class="px-4"
      nav
    >
      <AdminNavbarItem
        v-for="(navItem, index) in nav"
        :key="index"
        :item="navItem"
      />
    </v-list>

    <template #append>
      <div class="admin-navbar--append px-4">
        <AdminNavbarLogout @logout="$listeners['logout']" />
      </div>
    </template>
  </v-navigation-drawer>
</template>

<script>
import AdminNavbarItem from './components/AdminNavbarItem'
import AdminNavbarLogout from './components/AdminNavbarLogout'

export default {
  name: 'AdminNavbar',
  components: {
    AdminNavbarItem,
    AdminNavbarLogout,
  },
  props: {
    width: {
      type: [String, Number],
      default: 256,
    },
  },
  data() {
    return {
      nav: [
        {
          icon: 'mdi-view-dashboard',
          title: 'ダッシュボード',
          to: { name: 'AdminDashboard' },
        },
        {
          icon: 'mdi-database',
          title: '問題集一覧',
          to: { name: 'AdminWorks' },
        },
        {
          icon: 'mdi-account',
          title: 'アカウント一覧',
          to: { name: 'AdminUsers' },
        },
      ],
    }
  },
}
</script>

<style lang="scss" scoped>
.admin-navbar {
  background: #22385e !important;
}
.admin-navbar--prepend,
.admin-navbar--append {
  display: flex;
  align-items: center;
  justify-content: center;
}
.admin-navbar--prepend {
  height: 100px;
}
.admin-navbar--append {
  height: 72px;
}
</style>
