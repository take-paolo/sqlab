<template>
  <v-footer color="white">
    <BaseButton
      class="font-weight-bold"
      color="primary"
      depressed
      :disabled="isProcessing"
      :loading="isProcessing"
      @click.stop="$emit('test-query')"
    >
      答え合わせ
    </BaseButton>

    <BaseButton
      class="ml-2 primary--text font-weight-bold"
      color="primary lighten-4"
      depressed
      @click.stop="$emit('open-example-answer-modal')"
    >
      解答例
    </BaseButton>

    <v-spacer />

    <BaseButtonIcon
      id="preference-list"
      @click.stop="$emit('open-preference-list-modal')"
    >
      <BaseIcon>mdi-cog</BaseIcon>
    </BaseButtonIcon>
    <BaseTooltip
      top
      activator="#preference-list"
    >
      設定
    </BaseTooltip>

    <BaseButtonIcon
      id="shortcut-list"
      class="ml-2"
      @click.stop="$emit('open-shortcut-list-modal')"
    >
      <BaseIcon>mdi-keyboard-settings-outline</BaseIcon>
    </BaseButtonIcon>
    <BaseTooltip
      top
      activator="#shortcut-list"
    >
      ショートカット
    </BaseTooltip>
  </v-footer>
</template>

<script>
export default {
  name: 'PracticeFooter',
  props: {
    isProcessing: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
