<template>
  <v-list-item-icon class="ml-6 align-self-center">
    <v-tooltip
      top
      content-class="shadow"
      z-index="999"
      color="primary"
    >
      <template #activator="{ on, attrs }">
        <BaseIcon
          :color="iconColor"
          v-bind="attrs"
          @click.stop="$emit('toggle-bookmark', item)"
          v-on="on"
        >
          {{ icon }}
        </BaseIcon>
      </template>
      <span>{{ tooltipText }}</span>
    </v-tooltip>
  </v-list-item-icon>
</template>

<script>
export default {
  name: 'AppIconBookmark',
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    icon() {
      return this.item.bookmarked ? 'mdi-star' : 'mdi-star-outline'
    },
    iconColor() {
      return this.item.bookmarked ? 'accent' : 'font'
    },
    tooltipText() {
      return this.item.bookmarked ? 'お気に入り削除' : 'お気に入り登録'
    },
  },
}
</script>
