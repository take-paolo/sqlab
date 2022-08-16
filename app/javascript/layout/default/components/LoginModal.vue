<template>
  <BaseModal
    :is-active.sync="isVisibleModal"
    max-width="450px"
  >
    <template #title>ログイン</template>

    <template #text>
      <AppLoginContent class="px-7 py-6" />
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'LoginModal',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    isVisibleModal: {
      get() {
        return this.isActive
      },
      set(val) {
        this.$emit('update', val)
      },
    },
  },
}
</script>
