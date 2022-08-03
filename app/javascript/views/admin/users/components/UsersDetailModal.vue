<template>
  <BaseModal
    :is-active="isActive"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>アカウント詳細</template>

    <template #text>
      <BaseTable class="px-6 py-3">
        <tbody>
          <tr
            v-for="(value, key, index) in user"
            :key="index"
          >
            <th class="text-default">{{ $t(key) }}</th>
            <td class="py-3 text-pre-wrap text-default">{{ value }}</td>
          </tr>
        </tbody>
      </BaseTable>
    </template>

    <template #actions>
      <BaseButton
        color="error"
        depressed
        @click="$emit('show-user-delete-modal', user)"
      >
        削除
      </BaseButton>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'UsersDetailModal',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    user: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style lang="scss" scoped>
th {
  width: 150px;
}
</style>
