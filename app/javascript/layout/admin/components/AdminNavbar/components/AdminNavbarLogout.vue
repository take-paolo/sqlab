<template>
  <BaseButton
    outlined
    width="100%"
    height="44px"
    color="white"
    @click="$emit('logout')"
  >
    <BaseIcon
      left
      color="inherit"
    >
      mdi-logout
    </BaseIcon>
    ログアウト
  </BaseButton>
</template>

<script>
export default {
  name: 'AdminNavbarLogout',
}
</script>
