<template>
  <BaseModal
    :is-active="isActive"
    max-width="512px"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>{{ result.title }}</template>

    <template #text>
      <div class="practice-test-result-content px-6 py-3">{{ result.text }}</div>
    </template>

    <template
      v-if="result.isSuccess"
      #actions
    >
      <BaseButton
        class="font-weight-bold"
        color="primary"
        depressed
        @click.stop="$emit('move-next-practice')"
      >
        次に進む
      </BaseButton>
      <BaseButton
        class="primary--text font-weight-bold"
        color="primary lighten-4"
        depressed
        @click.stop="$emit('open-example-answer-modal')"
      >
        解答例
      </BaseButton>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'PracticeModalTestResult',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    result: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-test-result-content {
  min-height: 128px;
}
</style>
