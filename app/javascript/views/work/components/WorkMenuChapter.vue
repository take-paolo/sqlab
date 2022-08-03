<template>
  <v-subheader class="text-large font-weight-bold font--text text--darken-1 px-3">
    {{ name }}
  </v-subheader>
</template>

<script>
export default {
  name: 'WorkMenuChapter',
  props: {
    name: {
      type: String,
      default: '',
    },
  },
}
</script>
