<template>
  <BaseTable
    class="base-table--hover"
    fixed-header
    :height="height"
    dense
  >
    <thead>
      <tr>
        <th
          v-for="(column, index) in table.fields"
          :key="index"
        >
          {{ column }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr
        v-for="(record, recordIndex) in table.records"
        :key="recordIndex"
      >
        <td
          v-for="(value, valueIndex) in record"
          :key="valueIndex"
        >
          {{ value }}
        </td>
      </tr>
    </tbody>
  </BaseTable>
</template>

<script>
import { addTabIndexTo } from '@/utils/tabindex'

export default {
  name: 'PracticeTable',
  props: {
    height: {
      type: [String, Number],
      default: null,
    },
    table: {
      type: Object,
      default: () => ({}),
    },
  },
  mounted() {
    this.$nextTick(function () {
      addTabIndexTo('table', this.$el)
    })
  },
}
</script>
