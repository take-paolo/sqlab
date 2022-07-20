<template>
  <BaseMenu
    :activator="activator"
    top
    offset-y
    nudge-left="50%"
    nudge-top="4px"
  >
    <BaseButton
      depressed
      :href="url"
      target="_blank"
      rel="noopener"
      color="primary"
    >
      新しいタブでER図を開く
    </BaseButton>
  </BaseMenu>
</template>

<script>
export default {
  name: 'PracticeMenuErDiagram',
  props: {
    activator: {
      type: undefined,
      required: true,
    },
    url: {
      type: String,
      default: '',
    },
  },
}
</script>
