<template>
  <BaseModal
    :is-active="isActive"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>解答例</template>

    <template #text>
      <div class="practice-example-answer-content">
        <PracticeEditor
          id="example-answer-editor"
          ref="exampleAnswerEditor"
          :value="answer"
          reactive
          read-only
        />
      </div>
    </template>
  </BaseModal>
</template>

<script>
import PracticeEditor from './PracticeEditor'

export default {
  name: 'PracticeModalExampleAnswer',
  components: {
    PracticeEditor,
  },
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    answer: {
      type: String,
      default: '',
    },
  },
  watch: {
    isActive() {
      setTimeout(() => {
        this.$refs.exampleAnswerEditor.focus()
      }, 1)
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-example-answer-content {
  height: 60vh;
}
</style>
