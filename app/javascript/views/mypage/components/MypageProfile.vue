<template>
  <div>
    <MypageCardTitle>プロフィール</MypageCardTitle>

    <v-card
      class="px-8 py-9 rounded-lg shadow-low"
      color="white"
    >
      <v-card-text class="text-center">
        <BaseAvatar
          class="mb-4"
          size="72"
          color="primary"
        >
          <BaseIcon
            size="40"
            color="white"
          >
            mdi-account
          </BaseIcon>
        </BaseAvatar>
        <v-card-title class="text-large justify-center mb-1">{{ user.name }}</v-card-title>
        <v-card-subtitle>{{ user.email }}</v-card-subtitle>

        <div class="mt-10">
          <BaseButton
            class="mypage-profile-btn"
            depressed
            width="100%"
            height="44px"
            @click="$emit('show-account-setting-modal')"
          >
            アカウント設定
          </BaseButton>
          <BaseButton
            class="mypage-profile-btn"
            depressed
            width="100%"
            height="44px"
            @click="$emit('logout')"
          >
            ログアウト
          </BaseButton>
        </div>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import MypageCardTitle from './MypageCardTitle'

export default {
  name: 'MypageProfile',
  components: {
    MypageCardTitle,
  },
  props: {
    user: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.mypage-profile-btn {
  max-width: 240px;

  &:not(:first-child) {
    margin-top: 0.5rem;
  }
}
</style>
