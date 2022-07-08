<template>
  <BaseModal
    :is-active="isActive"
    max-width="720px"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>ショートカット</template>

    <template #text>
      <div class="pa-6">
        <v-list
          v-for="(shortcut, index) in shortcuts"
          :key="index"
          :class="index !== 0 ? 'mt-4' : 'mt-n4'"
          color="transparent"
        >
          <v-subheader class="px-0 text-default">
            <BaseIcon
              dense
              color="primary"
            >
              mdi-rhombus-medium
            </BaseIcon>
            <span class="font--text">{{ shortcut.scope }}</span>
          </v-subheader>

          <BaseDivider class="practice-shortcut-divider" />

          <BaseTable
            class="practice-shortcut-table base-table--striped"
            dense
          >
            <tbody>
              <tr
                v-for="item in shortcut.items"
                :key="item.key"
              >
                <td>{{ item.key }}</td>
                <td>{{ item.command }}</td>
              </tr>
            </tbody>
          </BaseTable>

          <BaseAlert
            v-if="shortcut.note"
            class="practice-shortcut-note mt-4 mb-0 px-3 text-small"
            dense
            color="primary"
            text
            icon="mdi-information-outline"
          >
            {{ shortcut.note }}
          </BaseAlert>
        </v-list>
      </div>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'PracticeModalShortcutList',
  props: {
    isActive: {
      type: Boolean,
      required: true,
    },
    shortcuts: {
      type: Array,
      required: true,
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-shortcut-table {
  tr {
    th,
    td {
      padding: 0.5rem 1rem !important;
      &:first-child {
        width: 35%;
      }
    }
  }
}
.practice-shortcut-divider {
  border-width: 2px !important;
  background: var(--v-primary-base);
  margin-bottom: 0.75rem;
}
</style>

<style lang="scss">
.practice-shortcut-note {
  .v-alert__icon {
    font-size: 20px;
    margin-right: 4px;
  }
}
</style>
