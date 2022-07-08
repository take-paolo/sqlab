<template>
  <v-list-item
    class="rounded-l-xl overflow-hidden px-4"
    :to="item.to"
    :disabled="item.disabled"
    color="primary"
    :ripple="{ center: true, class: 'primary--text' }"
  >
    <v-list-item-icon class="mr-1">
      <BaseIcon dense>
        {{ item.icon }}
      </BaseIcon>
    </v-list-item-icon>
    <v-list-item-title class="font-weight-regular">
      {{ item.title }}
    </v-list-item-title>
  </v-list-item>
</template>

<script>
export default {
  name: 'UserDrawerMenuListItem',
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>
