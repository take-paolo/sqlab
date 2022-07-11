<template>
  <v-card
    class="work-detail pa-7"
    color="white"
    rounded="lg"
  >
    <v-card-title class="text-large font--text text--darken-1">概要</v-card-title>
    <v-card-text class="mt-3 text-default">{{ work.description }}</v-card-text>

    <v-card-title class="text-large font--text text--darken-1 mt-7">問題数</v-card-title>
    <v-card-text class="mt-3 text-default">全{{ work.totalPractices }}問</v-card-text>
  </v-card>
</template>

<script>
export default {
  name: 'WorkDetail',
  props: {
    work: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.work-detail {
  box-shadow: var(--shadow-low) !important;
}
</style>
