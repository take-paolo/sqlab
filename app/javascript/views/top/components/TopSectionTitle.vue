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
  font-size: 2rem;
  line-height: 2.5rem;
  letter-spacing: normal;
  font-weight: 900;
  color: var(--v-font-darken1);
}
</style>
