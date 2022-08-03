<template>
  <v-card
    class="px-4 py-6"
    color="primary white--text"
  >
    <v-card-text class="text-center">
      <BaseAvatar
        class="mb-3"
        color="white"
      >
        <BaseIcon
          size="28"
          color="primary"
        >
          mdi-account
        </BaseIcon>
      </BaseAvatar>
      <v-card-title class="text-default justify-center">ゲストユーザー</v-card-title>
      <v-card-subtitle>guest@sqlab.com</v-card-subtitle>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  name: 'UserDrawerHeading',
}
</script>
