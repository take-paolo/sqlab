<template>
  <BaseModal
    :is-active="isActive"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>{{ modalTitle }}</template>

    <template #text>
      <BaseTable class="px-6 py-3">
        <tbody>
          <tr
            v-for="(value, key, index) in item"
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
        color="success"
        depressed
        @click.stop="$emit('show-edit-modal')"
      >
        編集
      </BaseButton>
      <BaseButton
        color="error"
        depressed
        @click.stop="$emit('show-delete-modal')"
      >
        削除
      </BaseButton>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'WorksDetailModal',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      default: '',
    },
    item: {
      type: Object,
      required: true,
    },
  },
  computed: {
    modalTitle() {
      return this.title + '詳細'
    },
  },
}
</script>

<style lang="scss" scoped>
th {
  width: 150px;
}
</style>
