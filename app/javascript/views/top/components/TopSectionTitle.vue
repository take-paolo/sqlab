<template>
  <h2 class="section-title text-center">
    <slot />
  </h2>
</template>

<script>
export default {
  name: 'TopSectionTitle',
}
</script>

<style lang="scss" scoped>
.section-title {
  font-size: 2rem !important;
  line-height: 2.5rem !important;
  letter-spacing: normal !important;
  font-weight: 900 !important;
  color: var(--v-font-darken1) !important;
  font-family: Roboto, 'Noto Sans JP', sans-serif !important;
}
</style>
