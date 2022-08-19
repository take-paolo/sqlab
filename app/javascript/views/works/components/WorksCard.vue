<template>
  <v-card
    class="overflow-hidden rounded-lg shadow-low pa-8"
    color="white"
  >
    <v-card-title class="text-x-large font--text text--darken-1">
      {{ work.name }}
    </v-card-title>
    <v-card-text class="text-default mt-5 text-pre-wrap">{{ work.description }}</v-card-text>
    <v-card-actions class="mt-8 pa-0">
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
