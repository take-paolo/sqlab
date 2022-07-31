<template>
  <aside>
    <AdminNavbar :width="adminSidebarWidth" />
  </aside>
</template>

<script>
import { mapGetters } from 'vuex'
import AdminNavbar from './AdminNavbar'

export default {
  name: 'TheSidebar',
  components: {
    AdminNavbar,
  },
  computed: {
    ...mapGetters('app', ['adminSidebarWidth']),
  },
}
</script>
