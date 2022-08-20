<template>
  <v-card
    class="practice-tabs-wrap shadow"
    rounded="lg"
  >
    <v-tabs
      ref="tabs"
      v-model="tab"
      class="practice-tabs"
      color="primary"
    >
      <slot name="tabs" />
    </v-tabs>

    <v-tabs-items
      v-model="tab"
      class="practice-tabs-items pa-2"
    >
      <slot name="tabs-items" />
    </v-tabs-items>

    <slot />
  </v-card>
</template>

<script>
export default {
  name: 'PracticeTabs',
  props: {
    activeTab: {
      type: [String, Number],
      default: null,
    },
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
  methods: {
    onResize() {
      this.$refs.tabs && this.$refs.tabs.onResize()
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-tabs-wrap {
  display: grid;
  grid-template-rows: 44px 1fr;
  grid-template-columns: 1fr;
  grid-template-areas: 'tabs' 'tabs-items';
  overflow: hidden;
  position: relative;
  z-index: 1;

  .practice-tabs {
    grid-area: tabs;
    overflow-x: scroll;
  }
  .practice-tabs-items {
    grid-area: tabs-items;
  }
}
</style>

<style lang="scss">
.practice-tabs-wrap {
  .practice-tabs {
    height: 100%;
    > .v-tabs-bar {
      height: 100%;
      > .v-slide-group__wrapper {
        height: 100%;
        > .v-tabs-bar__content {
          height: 100%;
          .v-tab:not(.v-tab--active) {
            color: var(--v-font-base);
            opacity: 0.62;
          }
        }
      }
    }
  }
  .practice-tabs-items {
    > .v-window__container {
      height: 100%;
      > .v-window-item {
        height: inherit;
      }
    }
  }
}
</style>
