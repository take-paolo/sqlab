<template>
  <div>
    <BaseButtonIcon
      :id="item.id"
      class="d-flex align-center justify-center mx-auto"
      :to="item.to"
      v-bind="$attrs"
      @click.stop="$emit('click')"
    >
      <BaseIcon>{{ item.icon }}</BaseIcon>
    </BaseButtonIcon>

    <BaseTooltip
      left
      :activator="'#' + item.id"
    >
      {{ item.tooltip }}
    </BaseTooltip>
  </div>
</template>

<script>
export default {
  name: 'NavbarItem',
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>
