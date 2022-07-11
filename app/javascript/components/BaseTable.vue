<template>
  <v-simple-table
    class="base-table"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </v-simple-table>
</template>

<script>
export default {
  name: 'BaseTable',
  inheritAttrs: false,
}
</script>

<style lang="scss">
.v-data-table {
  &.base-table {
    &--striped {
      tr {
        &:nth-child(2n) {
          td {
            background: var(--v-primary-lighten5);
          }
        }
      }
    }
    &--hover {
      tr {
        &:hover {
          td {
            background: var(--v-primary-lighten5) !important;
          }
        }
      }
    }
    th {
      color: var(--v-font-base) !important;
    }
  }
}
</style>
