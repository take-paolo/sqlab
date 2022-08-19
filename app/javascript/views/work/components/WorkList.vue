<template>
  <div class="work-list">
    <v-card
      v-for="(chapter, index) in work.chapters"
      :key="chapter.id"
      class="work-list-item px-6 py-4"
      :class="index !== 0 ? 'mt-10' : ''"
      color="white"
      rounded="lg"
    >
      <v-subheader class="text-large font-weight-bold font--text text--darken-1 px-3 mb-2">
        {{ chapter.name }}
      </v-subheader>

      <BaseDivider class="work-divider mt-1 mb-2 rounded-lg" />

      <v-list>
        <AppPracticeListItem
          v-for="practice in chapter.practices"
          :key="practice.id"
          class="rounded-lg"
          :slug="work.slug"
          :practice="practice"
          :logged-in="loggedIn"
        />
      </v-list>
    </v-card>
  </div>
</template>

<script>
export default {
  name: 'WorkList',
  props: {
    work: {
      type: Object,
      default: () => ({}),
    },
    loggedIn: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style lang="scss" scoped>
.work-list-item {
  box-shadow: var(--shadow-low) !important;
}
.work-divider {
  border-width: 2px !important;
  background: var(--v-primary-base);
}
</style>
