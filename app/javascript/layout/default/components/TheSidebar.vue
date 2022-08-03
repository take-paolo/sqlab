<template>
  <aside>
    <nav>
      <DefaultNavbar
        :width="sidebarWidth"
        :is-practice-page="isPracticePage"
        :logged-in="loggedIn"
        @toggle-work-drawer="toggleWorkDrawer"
        @toggle-user-drawer="toggleUserDrawer"
      />
      <WorkDrawer
        v-if="isPracticePage"
        :is-active.sync="isVisibleWorkDrawer"
        :style="{ marginRight: sidebarWidth + 'px' }"
      />
      <UserDrawer
        :is-active.sync="isVisibleUserDrawer"
        :style="{ marginRight: sidebarWidth + 'px' }"
        @logout="logout"
      />
    </nav>
  </aside>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import DefaultNavbar from './Navbar'
import WorkDrawer from './WorkDrawer'
import UserDrawer from './UserDrawer'

export default {
  name: 'TheSidebar',
  components: {
    DefaultNavbar,
    WorkDrawer,
    UserDrawer,
  },
  data() {
    return {
      isVisibleWorkDrawer: false,
      isVisibleUserDrawer: false,
    }
  },
  computed: {
    ...mapGetters('app', ['sidebarWidth', 'isPracticePage']),
    ...mapGetters('users', ['authUser']),
    loggedIn() {
      return Boolean(this.authUser)
    },
  },
  methods: {
    ...mapActions('users', ['logoutUser']),
    ...mapActions('app', ['openFlashMessage']),
    toggleWorkDrawer() {
      this.isVisibleWorkDrawer = !this.isVisibleWorkDrawer
    },
    toggleUserDrawer() {
      this.isVisibleUserDrawer = !this.isVisibleUserDrawer
    },
    logout() {
      this.logoutUser()
      this.isVisibleUserDrawer = false
      this.openFlashMessage('logoutSuccess')
      if (this.$route.name === 'Top') return
      this.$router.push({ name: 'Top' })
    },
  },
}
</script>
