<template>
  <BaseDrawer
    class="default-work-drawer"
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
          <v-subheader class="text-default font-weight-bold pa-0">
            <BaseIcon
              small
              color="primary"
            >
              mdi-rhombus-medium
            </BaseIcon>
            <span class="font--text">{{ chapter.name }}</span>
          </v-subheader>

          <v-list dense>
            <AppPracticeListItem
              v-for="practice in chapter.practices"
              :key="practice.id"
              class="rounded-l-xl pr-8"
              :slug="work.slug"
              :practice="practice"
              :logged-in="loggedIn"
              color="primary"
              :input-value="activePractice.id === practice.id"
            />
          </v-list>

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

export default {
  name: 'WorkDrawer',
  components: {
    WorkDrawerHeading,
  },
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    loggedIn: {
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
.default-work-drawer {
  max-width: 724px;
}
</style>
