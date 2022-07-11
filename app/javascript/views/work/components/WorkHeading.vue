<template>
  <div class="text-h1 text-center font-weight-black font--text text--darken-1 py-8">
    {{ title }}
  </div>
</template>

<script>
export default {
  name: 'WorkHeading',
  props: {
    title: {
      type: String,
      default: '',
    },
  },
}
</script>
