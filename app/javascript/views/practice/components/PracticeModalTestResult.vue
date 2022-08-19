<template>
  <BaseModal
    :is-active="isActive"
    max-width="512px"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>{{ result.title }}</template>

    <template #text>
      <div class="practice-test-result-content px-6 py-3 text-pre-wrap">{{ result.text }}</div>
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

      <v-spacer></v-spacer>

      <BaseButton
        class="font-weight-bold white--text"
        color="#00ACEE"
        depressed
        @click.stop="twitterShare"
      >
        <BaseIcon
          class="ml-0 mr-1"
          left
          color="white"
        >
          mdi-twitter
        </BaseIcon>
        結果をシェアする
      </BaseButton>
    </template>
  </BaseModal>
</template>

<script>
import { removeTrailingSlash } from '@/utils/helpers'

export default {
  name: 'PracticeModalTestResult',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    practice: {
      type: Object,
      default: () => ({}),
    },
    result: {
      type: Object,
      default: () => ({}),
    },
  },
  methods: {
    twitterShare() {
      const text = `SQL練習問題「${this.practice.name}」をクリアしました！%0a%0a%23sqlab%20%23sql%0a`
      let url = location.href
      url = removeTrailingSlash(url)
      url = url.split('/')
      url.pop()
      url = url.join('/')
      window.open(`https://twitter.com/intent/tweet?text=${text}&url=${url}`, '_blank')
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-test-result-content {
  min-height: 128px;
}
</style>
