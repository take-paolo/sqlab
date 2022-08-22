<template>
  <v-list-item class="works-list-item">
    <v-list-item-title :class="`${color}--text`">{{ item.name }}</v-list-item-title>

    <v-list-item-action class="works-list-item-action">
      <BaseButtonIcon
        class="works-list-item-btn"
        :ripple="false"
        @click.stop="$emit('show-detail-modal')"
      >
        <BaseIcon
          :color="color"
          size="20"
        >
          mdi-dots-grid
        </BaseIcon>
      </BaseButtonIcon>

      <BaseButtonIcon
        class="works-list-item-btn ml-1"
        :ripple="false"
        @click.stop="$emit('show-edit-modal')"
      >
        <BaseIcon
          :color="color"
          size="20"
        >
          mdi-pencil
        </BaseIcon>
      </BaseButtonIcon>

      <BaseButtonIcon
        class="works-list-item-btn ml-1"
        :ripple="false"
        @click.stop="$emit('show-delete-modal')"
      >
        <BaseIcon
          :color="color"
          size="20"
        >
          mdi-trash-can-outline
        </BaseIcon>
      </BaseButtonIcon>
    </v-list-item-action>
  </v-list-item>
</template>

<script>
export default {
  name: 'WorksListItem',
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
    color: {
      type: String,
      default: 'font',
    },
  },
}
</script>

<style lang="scss" scoped>
.works-list-item {
  cursor: move;
}
.works-list-item-btn {
  &:before {
    background: transparent;
  }
  &:hover {
    opacity: 0.5;
  }
}
.works-list-item-action {
  min-width: auto;
  flex-direction: row;
  margin-left: 1rem;
  margin-right: 1rem;
}
</style>
