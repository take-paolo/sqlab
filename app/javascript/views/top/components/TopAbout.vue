<template>
  <div class="about-section">
    <TopSectionTitle title="どんなサービス？" />

    <v-card-text class="text-large mt-8 font--text">
      <span class="primary--text font-weight-bold">SQLの練習ができる学習サービス</span>です。<br />
      練習問題が豊富で、環境構築不要！ブラウザ上ですぐにSQLを書いて結果を確認することができます。<br />
      SQLabを活用して技術書などで学んだSQLの知識をスキルに変えていきましょう！
    </v-card-text>
  </div>
</template>

<script>
import TopSectionTitle from './TopSectionTitle'

export default {
  name: 'TopAbout',
  components: {
    TopSectionTitle,
  },
}
</script>

<style lang="scss" scoped>
.about-section {
  max-width: 616px;
  margin: 96px auto;
  padding: 0 16px;
}
</style>
