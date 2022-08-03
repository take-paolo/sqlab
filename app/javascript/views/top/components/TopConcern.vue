<template>
  <div class="concern-section">
    <TopSectionTitle>こんな方におすすめ</TopSectionTitle>

    <div class="mt-14">
      <v-card class="concern-item">
        <div class="mr-8">
          <BaseImage
            class="concern-item__icon"
            width="80px"
            height="80px"
            eager
            :src="require('@/assets/man.svg')"
            alt=""
          />
        </div>
        <v-card-text class="concern-item__text bubble bubble--left rounded-lg text-default">
          とにかく多くの問題を解いて<span class="primary--text font-weight-bold">SQLのスキルを高めたい</span>
        </v-card-text>
      </v-card>

      <v-card class="concern-item flex-row-reverse mt-8">
        <div class="ml-8">
          <BaseImage
            class="concern-item__icon"
            width="80px"
            height="80px"
            eager
            :src="require('@/assets/woman.svg')"
            alt=""
          />
        </div>
        <v-card-text class="concern-item__text bubble bubble--right rounded-lg text-default">
          SQLの技術書を読んだけど<span class="primary--text font-weight-bold">次に何をすれば良いかわからない</span>
        </v-card-text>
      </v-card>

      <v-card class="concern-item mt-8">
        <div class="mr-8">
          <BaseImage
            class="concern-item__icon"
            width="80px"
            height="80px"
            eager
            :src="require('@/assets/man2.svg')"
            alt=""
          />
        </div>
        <v-card-text class="concern-item__text bubble bubble--left rounded-lg text-default">
          実際にSQLを書いてみたいけど<span class="primary--text font-weight-bold">環境構築やデータの用意が面倒だな</span
          >...
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>

<script>
import TopSectionTitle from './TopSectionTitle'

export default {
  name: 'TopConcern',
  components: {
    TopSectionTitle,
  },
  props: {
    faq: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
.concern-section {
  padding: 100px 16px 116px;
}
.concern-item {
  display: flex;
  align-items: center;
  justify-content: center;
}
.concern-item__icon {
  border-radius: 50%;
  box-shadow: 0px 0px 15px -5px var(--shadow-color);
}
.concern-item__text {
  width: auto;
  box-shadow: 0px 0px 15px -5px var(--shadow-color);
  position: relative;
  background: white;
  padding: 16px 20px;
  line-height: normal !important;
}
.bubble {
  position: relative;

  &::before {
    content: '';
    position: absolute;
    top: 40%;
    margin-top: -10px;
    border: 10px solid transparent;
  }
  &--left {
    &::before {
      border-right: 20px solid white;
      left: -30px;
    }
  }
  &--right {
    &::before {
      border-left: 20px solid white;
      right: -30px;
    }
  }
}
</style>
