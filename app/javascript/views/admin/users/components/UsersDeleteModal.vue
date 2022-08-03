<template>
  <BaseModal
    :is-active="isActive"
    max-width="450px"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>アカウント削除</template>

    <template #text>
      <p class="user-delete-modal-text text-default px-6 py-3 mb-0">本当に削除しますか?</p>
    </template>

    <template #actions>
      <BaseButton
        color="error"
        depressed
        @click="$emit('delete')"
      >
        削除
      </BaseButton>
      <BaseButton
        color="grey lighten-2"
        depressed
        @click="$emit('cancel')"
      >
        キャンセル
      </BaseButton>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'UsersDeleteModal',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style lang="scss" scoped>
.user-delete-modal-text {
  min-height: 104px;
}
</style>
