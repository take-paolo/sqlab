<template>
  <div>
    <MypageCardTitle>
      練習問題クリア回数
      <BaseIcon
        id="clear-count-icon"
        class="ml-2"
        size="20"
        color="font darken-1"
      >
        mdi-information-outline
      </BaseIcon>
    </MypageCardTitle>

    <BaseTooltip
      top
      activator="#clear-count-icon"
      content-class="py-2"
    >
      練習問題をクリアする度に回数が増えます
    </BaseTooltip>

    <v-card
      class="mypage-clear-count-card rounded-lg shadow-low"
      color="white"
    >
      <v-card-title class="mypage-clear-count-card__title justify-center font--text text--darken-1">0問</v-card-title>
    </v-card>
  </div>
</template>

<script>
import MypageCardTitle from './MypageCardTitle'

export default {
  name: 'MypageClearCount',
  components: {
    MypageCardTitle,
  },
}
</script>

<style lang="scss" scoped>
.mypage-clear-count-card {
  height: 100px;
}
.mypage-clear-count-card__title {
  font-size: 30px;
  height: inherit;
}
</style>
