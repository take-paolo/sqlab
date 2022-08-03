<template>
  <aside>
    <AdminNavbar
      :width="adminSidebarWidth"
      @logout="logout"
    />
  </aside>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import AdminNavbar from './AdminNavbar'

export default {
  name: 'TheSidebar',
  components: {
    AdminNavbar,
  },
  computed: {
    ...mapGetters('app', ['adminSidebarWidth']),
  },
  methods: {
    ...mapActions('users', ['logoutUser']),
    ...mapActions('app', ['openFlashMessage']),
    logout() {
      this.logoutUser()
      this.openFlashMessage('logoutSuccess')
      this.$router.push({ name: 'AdminLogin' })
    },
  },
}
</script>
