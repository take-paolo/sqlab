<template>
  <div class="work-menu">
    <v-card
      v-for="(chapter, index) in work.chapters"
      :key="chapter.id"
      class="work-menu-item px-6 py-4"
      :class="index !== 0 ? 'mt-10' : ''"
      color="white"
      rounded="lg"
    >
      <WorkMenuChapter :name="chapter.name" />

      <BaseDivider class="work-divider mt-1 mb-2 rounded-lg" />

      <WorkMenuPracticeList
        :slug="work.slug"
        :practices="chapter.practices"
      />
    </v-card>
  </div>
</template>

<script>
import WorkMenuChapter from './WorkMenuChapter'
import WorkMenuPracticeList from './WorkMenuPracticeList'

export default {
  name: 'WorkMenu',
  components: {
    WorkMenuChapter,
    WorkMenuPracticeList,
  },
  props: {
    work: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.work-menu-item {
  box-shadow: var(--shadow-low) !important;
}
.work-divider {
  border-width: 2px !important;
  background: var(--v-primary-base);
}
</style>
