<template>
  <div>
    <MypageCardTitle>お気に入りの練習問題</MypageCardTitle>
    <v-card
      class="mypage-bookmark-card pa-6 rounded-lg shadow-low"
      color="white"
    >
      <v-card-text>お気に入りの練習問題はありません。</v-card-text>
    </v-card>
  </div>
</template>

<script>
import MypageCardTitle from './MypageCardTitle'

export default {
  name: 'MypageBookmark',
  components: {
    MypageCardTitle,
  },
}
</script>

<style lang="scss" scoped>
.mypage-bookmark-card {
  min-height: 300px;
}
</style>
