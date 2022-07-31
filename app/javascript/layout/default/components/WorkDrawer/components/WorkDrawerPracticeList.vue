<template>
  <v-list dense>
    <WorkDrawerPracticeListItem
      v-for="(practice, index) in practices"
      :key="index"
      :practice="practice"
      :work-slug="workSlug"
      :active-practice-id="activePracticeId"
    />
  </v-list>
</template>

<script>
import WorkDrawerPracticeListItem from './WorkDrawerPracticeListItem'

export default {
  name: 'WorkDrawerPracticeList',
  components: {
    WorkDrawerPracticeListItem,
  },
  props: {
    practices: {
      type: Array,
      default: () => [],
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
}
</script>
