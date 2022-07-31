<template>
  <h1 class="base-page-heading">
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
  letter-spacing: 0.03em;
  font-weight: 900;
  text-align: center;
  margin-bottom: 60px;
  color: var(--v-font-darken1);
}
</style>
