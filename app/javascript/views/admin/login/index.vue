<template>
  <div class="admin-login">
    <AppFlashMessage />

    <AppPageHeading class="mb-8">管理画面ログイン</AppPageHeading>

    <LoginForm
      ref="loginForm"
      :item="user"
      @login="login"
    />
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LoginForm from './components/LoginForm'

export default {
  name: 'AdminLogin',
  components: {
    LoginForm,
  },
  data() {
    return {
      user: {
        email: '',
        password: '',
      },
    }
  },
  computed: {
    ...mapGetters('users', ['authUser']),
  },
  methods: {
    ...mapActions('users', ['loginUser']),
    ...mapActions('app', ['openFlashMessage']),
    async login(user) {
      try {
        await this.loginUser(user)
        this.openFlashMessage('loginSuccess')
        if (this.authUser.role === 'admin') {
          this.$router.push({ name: 'AdminDashboard' })
        } else {
          this.$router.push({ name: 'Top' })
        }
      } catch {
        this.openFlashMessage('loginFail')
        this.user.email = ''
        this.user.password = ''
        this.$refs.loginForm.resetForm()
      }
    },
  },
}
</script>

<style lang="scss" scoped>
.admin-login {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  width: 100%;
}
</style>
