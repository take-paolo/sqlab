<template>
  <h1 class="base-page-heading text-center py-10">
    {{ title }}
  </h1>
</template>

<script>
export default {
  name: 'BasePageHeading',
  props: {
    title: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.base-page-heading {
  font-size: 1.75rem;
  line-height: 2.5rem;
  letter-spacing: normal;
  font-weight: 900;
  color: var(--v-font-darken1);
}
</style>
