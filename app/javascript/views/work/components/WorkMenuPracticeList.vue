<template>
  <v-list>
    <WorkMenuPracticeListItem
      v-for="practice in practices"
      :key="practice.id"
      :slug="slug"
      :practice="practice"
    />
  </v-list>
</template>

<script>
import WorkMenuPracticeListItem from './WorkMenuPracticeListItem'

export default {
  name: 'WorkMenuPracticeList',
  components: {
    WorkMenuPracticeListItem,
  },
  props: {
    slug: {
      type: String,
      default: '',
    },
    practices: {
      type: Array,
      default: () => [],
    },
  },
}
</script>
