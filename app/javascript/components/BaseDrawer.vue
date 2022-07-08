<template>
  <v-navigation-drawer
    v-model="isVisibleDrawer"
    temporary
    :width="width"
    :tag="tag"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-navigation-drawer>
</template>

<script>
export default {
  name: 'BaseDrawer',
  inheritAttrs: false,
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    width: {
      type: [String, Number],
      default: '80%',
    },
    tag: {
      type: String,
      default: 'div',
    },
  },
  computed: {
    isVisibleDrawer: {
      get() {
        return this.isActive
      },
      set(val) {
        this.$emit('update:isActive', val)
      },
    },
  },
}
</script>
