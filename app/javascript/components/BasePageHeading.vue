<template>
  <h1
    class="text-h1 text-center py-10"
    v-bind="$attrs"
  >
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
