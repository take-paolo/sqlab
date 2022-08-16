<template>
  <AppContainer>
    <AppPageHeading class="mb-10">ログイン</AppPageHeading>
    <AppLoginContent class="login-content mx-auto" />
  </AppContainer>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'LoginView',
  mounted() {
    this.openFlashMessage('loginWarning')
  },
  methods: {
    ...mapActions('app', ['openFlashMessage']),
  },
}
</script>

<style lang="scss" scoped>
.login-content {
  max-width: 450px;
}
</style>
