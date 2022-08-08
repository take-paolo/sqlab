<template>
  <h1 class="app-page-heading">
    <slot />
  </h1>
</template>

<script>
export default {
  name: 'AppPageHeading',
  props: {
    title: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.app-page-heading {
  font-size: 1.875rem;
  line-height: 2.5rem;
  letter-spacing: 0.03em;
  font-weight: 900;
  text-align: center;
  margin-bottom: 4.25rem;
  color: var(--v-font-darken1);
}
</style>
