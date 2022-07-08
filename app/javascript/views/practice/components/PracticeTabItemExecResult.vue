<template>
  <v-card height="100%">
    <v-skeleton-loader
      v-if="isProcessing"
      class="practice-exec-result-loading"
      type="text"
      width="100%"
      height="100%"
      tile
    />
    <template v-else>
      <template v-if="status !== 0 || !values">
        <PracticeSheet>
          <span
            class="text-pre-wrap"
            v-text="message"
          />
        </PracticeSheet>
      </template>
      <template v-else>
        <PracticeTableTabs
          ref="tableTabs"
          :active-tab="activeTab"
          :tables="values"
          @update:activeTab="$listeners['update:activeTab']"
        />
      </template>
    </template>
  </v-card>
</template>

<script>
import PracticeSheet from './PracticeSheet'
import PracticeTableTabs from './PracticeTableTabs'

export default {
  name: 'PracticeTabItemExecResult',
  components: {
    PracticeSheet,
    PracticeTableTabs,
  },
  props: {
    activeTab: {
      type: Number,
      default: 0,
    },
    isProcessing: {
      type: Boolean,
      default: false,
    },
    status: {
      type: [String, Number],
      default: null,
    },
    values: {
      type: [String, Array],
      default: () => [],
    },
  },
  computed: {
    message() {
      return this.values || '実行結果なし'
    },
  },
  methods: {
    focus() {
      if (!Array.isArray(this.values)) return
      this.$refs.tableTabs.focus()
    },
  },
}
</script>

<style lang="scss">
.practice-exec-result-loading {
  > .v-skeleton-loader__text {
    height: 100%;
  }
}
</style>
