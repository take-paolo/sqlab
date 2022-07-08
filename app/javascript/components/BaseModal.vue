<template>
  <v-dialog
    v-model="isVisibleModal"
    :max-width="maxWidth"
    scrollable
    v-bind="$attrs"
    v-on="$listeners"
  >
    <v-card>
      <v-card-title
        v-if="$scopedSlots.title"
        class="px-6 pt-4 pb-3 text-large font-weight-bold"
      >
        <slot name="title" />
      </v-card-title>

      <v-divider v-if="$scopedSlots.title" />

      <v-card-text
        v-if="$scopedSlots.text"
        class="pa-0"
        tabindex="0"
      >
        <slot name="text" />
      </v-card-text>

      <v-divider v-if="$scopedSlots.actions" />

      <v-card-actions v-if="$scopedSlots.actions">
        <slot name="actions" />
      </v-card-actions>

      <BaseButtonClose @click.stop="isVisibleModal = false" />
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: 'BaseModal',
  inheritAttrs: false,
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    maxWidth: {
      type: [String, Number],
      default: 1024,
    },
  },
  computed: {
    isVisibleModal: {
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
