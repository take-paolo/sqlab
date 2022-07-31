<template>
  <a
    class="admin-navbar-logo"
    href="/"
    target="_blank"
  >
    <BaseImage
      class="mx-auto"
      max-width="88px"
      eager
      :src="require('@/assets/logo.svg')"
      alt="SQLab"
    />
  </a>
</template>

<script>
export default {
  name: 'AdminNavbarLogo',
}
</script>

<style lang="scss" scoped>
.admin-navbar-logo {
  &:hover {
    opacity: 0.5;
    transition: 0.3s cubic-bezier(0.25, 0.8, 0.5, 1);
  }
}
</style>
