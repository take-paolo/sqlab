<template>
  <AppContainer class="mypage-container">
    <v-row>
      <v-col>
        <AppPageHeading>マイページ</AppPageHeading>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="8">
        <MypageBookmark />
      </v-col>
      <v-col
        class="pl-10"
        cols="4"
      >
        <MypageClearCount />
        <MypageProfile
          class="mt-8"
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
import MypageClearCount from './components/MypageClearCount'
import MypageProfile from './components/MypageProfile'
import MypageAccountSettingModal from './components/MypageAccountSettingModal'
import MypageAccountDeleteDialog from './components/MypageAccountDeleteDialog'

export default {
  name: 'MypageView',
  components: {
    MypageBookmark,
    MypageClearCount,
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
    }
  },
  computed: {
    ...mapGetters('users', {
      user: 'authUser',
    }),
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
