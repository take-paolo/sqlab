<template>
  <div class="practice-table-tabs-wrap">
    <v-tabs
      v-model="tab"
      class="practice-table-tabs"
      active-class="primary white--text"
      background-color="primary lighten-4"
      height="32px"
      hide-slider
    >
      <BaseTab
        v-for="(table, index) in tables"
        :key="index"
        class="practice-table-tab"
      >
        <slot :table="table">result{{ index + 1 }}</slot>
      </BaseTab>
    </v-tabs>
    <v-tabs-items
      v-model="tab"
      class="practice-table-tabs-items"
    >
      <BaseTabItem
        v-for="(table, index) in tables"
        :key="index"
        eager
      >
        <PracticeTable
          :height="tableHeight"
          :table="table"
        />
      </BaseTabItem>
    </v-tabs-items>
  </div>
</template>

<script>
import PracticeTable from './PracticeTable'

export default {
  name: 'PracticeTableTabs',
  components: {
    PracticeTable,
  },
  props: {
    activeTab: {
      type: [String, Number],
      default: null,
    },
    tables: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      tableHeight: '',
    }
  },
  computed: {
    tab: {
      get() {
        return this.activeTab
      },
      set(val) {
        this.$emit('update:activeTab', val)
      },
    },
  },
  beforeMount() {
    window.addEventListener('resize', this.calcTableHeight)
  },
  mounted() {
    this.focus()
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.calcTableHeight)
  },
  methods: {
    focus() {
      if (!this.tables.length) return

      setTimeout(() => {
        this.calcTableHeight()
        const activeTabItem = this.$el.querySelector('.v-window-item--active')
        activeTabItem.querySelector('table').focus()
      }, 1)
    },
    calcTableHeight() {
      this.tableHeight = this.$el.clientHeight - 32
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-table-tabs-wrap {
  display: grid;
  grid-template-rows: 32px 1fr;
  grid-template-columns: 1fr;
  grid-template-areas: 'table-tabs' 'table-tabs-items';
  height: 100%;
  width: 100%;

  .practice-table-tabs {
    grid-area: table-tabs;
    overflow-x: scroll;
  }
  .practice-table-tabs-items {
    grid-area: table-tabs-items;
  }
}
.practice-table-tab {
  text-transform: lowercase;
  min-width: auto;
}
</style>

<style lang="scss">
.practice-table-tabs-wrap {
  .practice-table-tabs {
    > .v-tabs-bar {
      height: 100%;
    }
  }
}
</style>
