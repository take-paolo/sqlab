<template>
  <v-card height="100%">
    <template v-if="!tables.length">
      <PracticeSheet class="d-flex align-center text-center">
        <BaseIcon>mdi-table-off</BaseIcon>
      </PracticeSheet>
    </template>
    <template v-else>
      <PracticeTableTabs
        ref="tableTabs"
        :active-tab="activeTab"
        :tables="tables"
        @update:activeTab="$listeners['update:activeTab']"
      >
        <template #default="slotProps">
          {{ slotProps.table.name }}
        </template>
      </PracticeTableTabs>
    </template>
  </v-card>
</template>

<script>
import PracticeSheet from './PracticeSheet'
import PracticeTableTabs from './PracticeTableTabs'

export default {
  name: 'PracticeTabItemSampleDatabase',
  components: {
    PracticeSheet,
    PracticeTableTabs,
  },
  props: {
    activeTab: {
      type: Number,
      default: 0,
    },
    tables: {
      type: Array,
      default: () => [],
    },
  },
  methods: {
    focus() {
      if (!this.tables.length) return
      this.$refs.tableTabs.focus()
    },
  },
}
</script>
