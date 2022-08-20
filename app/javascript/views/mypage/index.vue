<template>
  <AppContainer class="mypage-container">
    <v-row>
      <v-col>
        <AppPageHeading>マイページ</AppPageHeading>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="8">
        <MypageBookmark
          :bookmark-practices="bookmarkPractices"
          :logged-in="loggedIn"
          @remove-bookmark="removeBookmark"
        />
      </v-col>
      <v-col
        class="pl-10"
        cols="4"
      >
        <MypageProfile
          :user="user"
          @show-account-setting-modal="showAccountSettingModal"
          @logout="logout"
        />
      </v-col>
    </v-row>

    <MypageAccountSettingModal
      :is-active.sync="isVisibleAccountSettingModal"
      :user="userEdit"
      :error-messages="errorMessages"
      @update="updateUser"
      @show-account-delete-dialog="showAccountDeleteDialog"
    />
    <MypageAccountDeleteDialog
      :is-active.sync="isVisibleAccountDeleteDialog"
      @delete="deleteUser"
      @cancel="isVisibleAccountDeleteDialog = false"
    />
  </AppContainer>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

import MypageBookmark from './components/MypageBookmark'
import MypageProfile from './components/MypageProfile'
import MypageAccountSettingModal from './components/MypageAccountSettingModal'
import MypageAccountDeleteDialog from './components/MypageAccountDeleteDialog'

export default {
  name: 'MypageView',
  components: {
    MypageBookmark,
    MypageProfile,
    MypageAccountSettingModal,
    MypageAccountDeleteDialog,
  },
  data() {
    return {
      userEdit: {},
      isVisibleAccountSettingModal: false,
      isVisibleAccountDeleteDialog: false,
      errorMessages: {},
      bookmarkPractices: [],
    }
  },
  computed: {
    ...mapGetters('users', {
      user: 'authUser',
    }),
    loggedIn() {
      return Boolean(this.user)
    },
  },
  created() {
    this.fetchBookmarkPractices()
  },
  methods: {
    ...mapActions('users', ['fetchAuthUser', 'logoutUser', 'resetAuthUser']),
    ...mapActions('app', ['openFlashMessage']),
    showAccountSettingModal() {
      this.userEdit = Object.assign({}, this.user)
      this.isVisibleAccountSettingModal = true
    },
    showAccountDeleteDialog() {
      this.isVisibleAccountDeleteDialog = true
    },
    async updateUser(user) {
      try {
        await this.$axios.patch('auth_user', user)
        this.isVisibleAccountSettingModal = false
        this.userEdit = {}
        this.fetchAuthUser()
      } catch (err) {
        this.errorMessages = err.response.data
      }
    },
    async deleteUser() {
      await this.$axios.delete('auth_user')
      this.isVisibleAccountDeleteDialog = false
      this.isVisibleAccountSettingModal = false
      this.resetAuthUser()
      this.$router.push({ name: 'Top' })
      this.openFlashMessage('deleteUserSuccess')
    },
    async logout() {
      await this.logoutUser()
      this.openFlashMessage('logoutSuccess')
      location.href = '/'
    },
    async fetchBookmarkPractices() {
      await this.$axios.get('bookmarks').then(res => {
        this.bookmarkPractices = res.data
      })
    },
    removeBookmark(id) {
      this.bookmarkPractices = this.bookmarkPractices.filter(practice => practice.id !== id)
    },
  },
}
</script>

<style lang="scss" scoped>
.mypage-container {
  width: 90%;
  max-width: 1400px;
  margin: 0 auto;
}
</style>
