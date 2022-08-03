<template>
  <BaseContainerAdmin>
    <BasePageHeading title="アカウント一覧" />

    <UsersTable
      :users="users"
      @show-user-detail-modal="showUserDetailModal"
      @show-user-delete-modal="showUserDeleteModal"
    />

    <UsersDetailModal
      :is-active.sync="isVisibleUserDetailModal"
      :user="userDetail"
      @show-user-delete-modal="showUserDeleteModal"
    />
    <UsersDeleteModal
      :is-active.sync="isVisibleUserDeleteModal"
      @delete="deleteUser(userDelete)"
      @cancel="closeUserDeleteModal()"
    />
  </BaseContainerAdmin>
</template>

<script>
import { formatDate } from '@/utils/format-date'
import { pullObjectFrom } from '@/utils/helpers'
import cloneDeep from 'lodash.clonedeep'
import UsersTable from './components/UsersTable'
import UsersDetailModal from './components/UsersDetailModal'
import UsersDeleteModal from './components/UsersDeleteModal'

export default {
  name: 'AdminUsers',
  components: {
    UsersTable,
    UsersDetailModal,
    UsersDeleteModal,
  },
  data() {
    return {
      users: [],
      isVisibleUserDetailModal: false,
      isVisibleUserDeleteModal: false,
      userDetail: {},
      userDelete: {},
    }
  },
  created() {
    this.fetchUsers()
  },
  methods: {
    async fetchUsers() {
      await this.$axios.get('admin/users').then(res => (this.users = res.data))
    },
    async deleteUser(user) {
      await this.$axios.delete(`admin/users/${user.id}`, user).then(() => {
        this.users = pullObjectFrom(this.users, user)
        this.closeUserDeleteModal()
        this.closeUserDetailModal()
      })
    },
    showUserDetailModal(user) {
      user = cloneDeep(user)
      user.createdAt = formatDate(user.createdAt)
      user.updatedAt = formatDate(user.updatedAt)
      this.userDetail = user
      this.isVisibleUserDetailModal = true
    },
    closeUserDetailModal() {
      this.userDetail = {}
      this.isVisibleUserDetailModal = false
    },
    showUserDeleteModal(user) {
      this.userDelete = user
      this.isVisibleUserDeleteModal = true
    },
    closeUserDeleteModal() {
      this.userDelete = {}
      this.isVisibleUserDeleteModal = false
    },
  },
}
</script>
