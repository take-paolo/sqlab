<template>
  <aside>
    <nav>
      <DefaultNavbar
        :width="sidebarWidth"
        :is-practice-page="isPracticePage"
        :logged-in="loggedIn"
        @toggle-work-drawer="toggleWorkDrawer"
        @toggle-user-drawer="toggleUserDrawer"
        @show-login-modal="showLoginModal"
      />
      <WorkDrawer
        :is-active.sync="isVisibleWorkDrawer"
        :logged-in="loggedIn"
        :style="{ marginRight: sidebarWidth + 'px' }"
      />
      <UserDrawer
        :is-active.sync="isVisibleUserDrawer"
        :style="{ marginRight: sidebarWidth + 'px' }"
        @logout="logout"
      />
      <LoginModal
        :is-active="isVisibleLoginModal"
        @update="switchLoginModal(false)"
      />
    </nav>
  </aside>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import DefaultNavbar from './Navbar'
import WorkDrawer from './WorkDrawer'
import UserDrawer from './UserDrawer'
import LoginModal from './LoginModal'

export default {
  name: 'TheSidebar',
  components: {
    DefaultNavbar,
    WorkDrawer,
    UserDrawer,
    LoginModal,
  },
  data() {
    return {
      isVisibleWorkDrawer: false,
      isVisibleUserDrawer: false,
    }
  },
  computed: {
    ...mapGetters('app', ['sidebarWidth', 'isPracticePage', 'isVisibleLoginModal']),
    ...mapGetters('users', ['authUser']),
    loggedIn() {
      return Boolean(this.authUser)
    },
  },
  methods: {
    ...mapActions('users', ['logoutUser']),
    ...mapActions('app', ['openFlashMessage', 'switchLoginModal']),
    toggleWorkDrawer() {
      this.isVisibleWorkDrawer = !this.isVisibleWorkDrawer
    },
    toggleUserDrawer() {
      this.isVisibleUserDrawer = !this.isVisibleUserDrawer
    },
    showLoginModal() {
      this.switchLoginModal(true)
    },
    async logout() {
      await this.logoutUser()
      this.isVisibleUserDrawer = false
      this.openFlashMessage('logoutSuccess')
      location.href = '/'
    },
  },
}
</script>
