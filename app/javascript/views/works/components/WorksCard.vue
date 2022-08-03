<template>
  <v-card class="works-card overflow-hidden rounded-lg pa-8">
    <v-card-title class="text-x-large font--text text--darken-1">
      {{ work.name }}
    </v-card-title>
    <v-card-text class="text-default mt-3">
      {{ work.description }}
    </v-card-text>
    <v-card-actions class="mt-5 pa-0">
      <BaseButton
        class="px-4 text-default"
        height="44px"
        depressed
        :to="{ name: 'Work', params: { slug: work.slug } }"
      >
        練習問題はこちら
      </BaseButton>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  name: 'WorksCard',
  props: {
    work: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.works-card {
  background: white;
  box-shadow: var(--shadow-low) !important;
}
</style>
