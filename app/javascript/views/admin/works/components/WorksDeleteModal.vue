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
            v-for="(value, key, index) in items"
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
        @click.stop="$emit('delete')"
      >
        削除
      </BaseButton>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'WorksDeleteModal',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      default: '',
    },
    items: {
      type: Object,
      required: true,
    },
  },
  computed: {
    modalTitle() {
      return this.title + '削除'
    },
  },
}
</script>

<style lang="scss" scoped>
th {
  width: 150px;
}
</style>
