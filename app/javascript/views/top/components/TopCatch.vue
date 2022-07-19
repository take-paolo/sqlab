<template>
  <div class="catch-section primary">
    <h2 class="catch-title">{{ concept }}</h2>

    <div class="mt-10 text-center">
      <BaseButton
        class="catch-btn px-15 text-large font-weight-bold primary--text rounded-lg"
        height="60px"
        color="white"
        depressed
        :to="{ name: 'Works' }"
      >
        問題を解いてみる
      </BaseButton>
    </div>
  </div>
</template>

<script>
export default {
  name: 'TopCatch',
  props: {
    concept: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.catch-section {
  padding: 88px 16px;
}
.catch-title {
  color: white;
  font-size: 36px;
  line-height: normal;
  font-weight: 900;
  letter-spacing: 0.05em;
  text-align: center;
}
.catch-btn {
  box-shadow: 0px 0px 10px -1px var(--shadow-color);
}
</style>
