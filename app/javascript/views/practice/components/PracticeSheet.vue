<template>
  <v-card
    class="px-4 py-3 primary lighten-5"
    height="100%"
  >
    <v-card-text>
      <slot />
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  name: 'PracticeSheet',
  props: {
    text: {
      type: String,
      default: '',
    },
  },
}
</script>
