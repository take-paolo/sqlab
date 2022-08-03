<template>
  <v-toolbar
    class="practice-toolbar-editor"
    tag="div"
    height="44px"
    color="transparent"
    flat
  >
    <BaseButtonIcon
      id="execute-query-btn"
      small
      :disabled="isProcessing"
      @click.stop="$emit('execute-query')"
    >
      <BaseIcon size="1.25rem">mdi-play</BaseIcon>
    </BaseButtonIcon>
    <BaseTooltip
      top
      :activator="'#execute-query-btn'"
    >
      実行
    </BaseTooltip>

    <BaseButtonIcon
      id="reset-btn"
      class="ml-2"
      small
      @click.stop="$emit('reset-editor')"
    >
      <BaseIcon size="1.25rem">mdi-restore</BaseIcon>
    </BaseButtonIcon>
    <BaseTooltip
      top
      :activator="'#reset-btn'"
    >
      リセット
    </BaseTooltip>
  </v-toolbar>
</template>

<script>
export default {
  name: 'PracticeToolbarEditor',
  props: {
    isProcessing: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-toolbar-editor {
  position: absolute;
  top: 0;
  right: 12px;
}
</style>
