<template>
  <v-card
    class="px-7 py-6"
    color="primary white--text"
    :to="{ name: 'Work', params: { slug: work.slug } }"
    :ripple="{ center: true, class: 'primary--text' }"
  >
    <v-card-title>{{ work.name }}</v-card-title>
    <v-card-subtitle>全{{ work.totalPractices }}問</v-card-subtitle>
  </v-card>
</template>

<script>
export default {
  name: 'WorkDrawerHeading',
  props: {
    work: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>
