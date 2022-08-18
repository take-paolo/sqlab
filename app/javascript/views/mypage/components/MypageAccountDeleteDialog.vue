<template>
  <BaseModal
    :is-active="isActive"
    max-width="500px"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>アカウント削除</template>

    <template #text>
      <p class="text-default px-6 py-5 mb-0">
        本当に削除しますか?<br />
        アカウントを削除をした場合、アカウントに紐づく<span class="error--text"
          >全てのデータが失われ、復元することはできません。</span
        >
      </p>
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
  name: 'MypageAccountDeleteDialog',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
