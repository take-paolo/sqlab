<template>
  <v-card
    class="overflow-hidden"
    color="white"
    rounded="sm"
  >
    <v-card
      class="practice-question-icon-wrapper d-flex align-center justify-center"
      color="primary"
      rounded="0"
    >
      <BaseIcon color="white">mdi-pencil</BaseIcon>
    </v-card>

    <v-card-text
      class="practice-question__text font-weight-bold d-flex align-center text-pre-wrap"
      v-text="question"
    />
  </v-card>
</template>

<script>
export default {
  name: 'PracticeQuestion',
  props: {
    question: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-question-icon-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 56px;
}
.practice-question__text {
  padding: 12px 16px 12px 72px;
  min-height: 56px;
}
</style>
