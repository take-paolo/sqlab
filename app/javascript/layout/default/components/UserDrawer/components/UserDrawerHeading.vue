<template>
  <v-card
    v-if="user"
    class="px-4 py-8"
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
      <v-card-title class="text-default justify-center">{{ user.name }}</v-card-title>
      <v-card-subtitle>{{ user.email }}</v-card-subtitle>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  name: 'UserDrawerHeading',
  props: {
    user: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>
