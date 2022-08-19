<template>
  <v-card>
    <v-card-text class="text-default">
      SNS認証でアカウント登録・ログインを行います。<br />
      事前に
      <router-link
        :to="{ name: 'Terms' }"
        @click.native="$emit('close-login-modal')"
      >
        利用規約
      </router-link>
      ・
      <router-link
        :to="{ name: 'Privacy' }"
        @click.native="$emit('close-login-modal')"
      >
        プライバシーポリシー
      </router-link>
      を確認してください。<br />
      アカウント登録を行った場合は、利用規約・プライバシーポリシーに同意したものとみなします。
    </v-card-text>

    <div class="mt-6">
      <BaseButton
        class="login-modal-btn d-block text-default white--text"
        href="/api/oauth/google"
        width="100%"
        height="44px"
        depressed
        color="#E94446"
        @click.native="setRedirectPath"
      >
        <BaseIcon
          class="mr-3"
          color="white"
          size="22"
          left
        >
          mdi-google
        </BaseIcon>
        <span class="login-modal-btn-text">Googleでログイン</span>
      </BaseButton>

      <BaseButton
        class="login-modal-btn d-block text-default white--text mt-3"
        href="/api/oauth/github"
        width="100%"
        height="44px"
        depressed
        color="#171515"
        @click.native="setRedirectPath"
      >
        <BaseIcon
          class="mr-3"
          color="white"
          size="22"
          left
        >
          mdi-github
        </BaseIcon>
        <span class="login-modal-btn-text">GitHubでログイン</span>
      </BaseButton>
    </div>
  </v-card>
</template>

<script>
import { removeTrailingSlash } from '@/utils/helpers'

export default {
  name: 'AppLoginContent',
  inheritAttrs: false,
  data() {
    return {
      excludedRedirectPaths: ['/login'],
    }
  },
  methods: {
    setRedirectPath() {
      let paths = [this.$route.path, this.$router.history._startLocation].map(item => removeTrailingSlash(item))

      paths.push('/')

      paths.some(path => {
        if (!this.excludedRedirectPaths.includes(path)) {
          return (localStorage.redirectPath = path)
        }
      })
    },
  },
}
</script>

<style lang="scss" scoped>
.login-modal-btn-text {
  position: relative;
  top: -1px;
}
</style>

<style lang="scss">
.login-modal-btn {
  .v-btn__content {
    height: inherit;
  }
}
</style>
