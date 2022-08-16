<template>
  <v-list-item
    class="work-practice-list-item rounded-l-xl overflow-hidden px-4"
    color="primary"
    :input-value="isActivePractice(practice)"
    :to="{ name: 'Practice', params: { slug: workSlug, id: practice.id, requiresAuth: practice.requiresAuth } }"
    :ripple="{ center: true, class: 'primary--text' }"
  >
    <v-list-item-title class="py-2 text-small font-weight-medium">
      {{ practice.name }}
    </v-list-item-title>
  </v-list-item>
</template>

<script>
export default {
  name: 'WorkDrawerPracticeListItem',
  props: {
    practice: {
      type: Object,
      default: () => ({}),
    },
    workSlug: {
      type: String,
      default: '',
    },
    activePracticeId: {
      type: Number,
      default: undefined,
    },
  },
  computed: {
    isActivePractice() {
      return function (practice) {
        return this.activePracticeId === practice.id
      }
    },
  },
}
</script>

<style lang="scss" scoped>
.work-practice-list-item {
  z-index: 1;
}
</style>
