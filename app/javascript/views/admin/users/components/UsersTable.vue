<template>
  <BaseTable class="users-table rounded-lg overflow-hidden">
    <thead>
      <tr class="primary">
        <th>ID</th>
        <th>名前</th>
        <th>権限</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr
        v-for="(user, key, index) in users"
        :key="index"
      >
        <td>{{ user.id }}</td>
        <td>{{ user.name }}</td>
        <td>{{ user.role }}</td>
        <td class="users-list-item-action">
          <BaseButton
            color="info"
            depressed
            @click="$emit('show-user-detail-modal', user)"
          >
            詳細
          </BaseButton>
          <BaseButton
            class="ml-1"
            color="error"
            depressed
            @click="$emit('show-user-delete-modal', user)"
          >
            削除
          </BaseButton>
        </td>
      </tr>
    </tbody>
  </BaseTable>
</template>

<script>
export default {
  name: 'UsersTable',
  props: {
    users: {
      type: Array,
      required: true,
    },
  },
}
</script>

<style lang="scss" scoped>
.users-table {
  box-shadow: 0 0 15px -1px var(--shadow-color-low) !important;

  th {
    color: white !important;
  }
  th,
  td {
    padding: 0 1.5rem !important;
    height: 56px !important;
    font-size: 1rem !important;
  }
}
</style>
