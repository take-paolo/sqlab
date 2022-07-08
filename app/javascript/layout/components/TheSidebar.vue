<template>
  <aside>
    <nav>
      <AppNavbar
        :width="sidebarWidth"
        :is-practice-page="isPracticePage"
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
      />
    </nav>
  </aside>
</template>

<script>
import AppNavbar from './Navbar'
import WorkDrawer from './WorkDrawer'
import UserDrawer from './UserDrawer'

export default {
  name: 'TheSidebar',
  components: {
    AppNavbar,
    WorkDrawer,
    UserDrawer,
  },
  data() {
    return {
      sidebarWidth: 72,
      isVisibleWorkDrawer: false,
      isVisibleUserDrawer: false,
    }
  },
  computed: {
    isPracticePage() {
      return this.$route.name === 'Practice'
    },
  },
  methods: {
    toggleWorkDrawer() {
      this.isVisibleWorkDrawer = !this.isVisibleWorkDrawer
    },
    toggleUserDrawer() {
      this.isVisibleUserDrawer = !this.isVisibleUserDrawer
    },
  },
}
</script>
