<template>
  <v-list-item
    class="work-menu-practice-list-item overflow-hidden rounded-lg px-4"
    :to="{ name: 'Practice', params: { slug: slug, id: practice.id } }"
    :ripple="{ center: true, class: 'primary--text' }"
  >
    <v-list-item-title class="font-weight-medium">
      {{ practice.name }}
    </v-list-item-title>
  </v-list-item>
</template>

<script>
export default {
  name: 'WorkMenuPracticeListItem',
  props: {
    slug: {
      type: String,
      default: '',
    },
    practice: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.work-menu-practice-list-item {
  z-index: 1;
}
</style>
