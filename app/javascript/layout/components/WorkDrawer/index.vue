<template>
  <BaseDrawer
    class="app-work-drawer"
    :is-active="isActive"
    app
    right
    @update:isActive="$listeners['update:isActive']"
  >
    <template v-if="work && activePractice">
      <WorkDrawerHeading :work="work" />

      <div class="py-4 pl-7">
        <div
          v-for="(chapter, index) in work.chapters"
          :key="index"
        >
          <WorkDrawerChapter :name="chapter.name" />

          <WorkDrawerPracticeList
            :practices="chapter.practices"
            :work-slug="work.slug"
            :active-practice-id="activePractice.id"
          />

          <BaseDivider
            v-if="index < work.chapters.length - 1"
            :key="index"
            class="mt-2 mb-4"
          />
        </div>
      </div>
    </template>
  </BaseDrawer>
</template>

<script>
import { mapGetters } from 'vuex'
import WorkDrawerHeading from './components/WorkDrawerHeading'
import WorkDrawerChapter from './components/WorkDrawerChapter'
import WorkDrawerPracticeList from './components/WorkDrawerPracticeList'

export default {
  name: 'WorkDrawer',
  components: {
    WorkDrawerHeading,
    WorkDrawerChapter,
    WorkDrawerPracticeList,
  },
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    ...mapGetters('works', ['work']),
    ...mapGetters('practices', {
      activePractice: 'practice',
    }),
  },
}
</script>

<style lang="scss" scoped>
.app-work-drawer {
  max-width: 624px;
}
</style>
