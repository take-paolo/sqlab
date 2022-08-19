<template>
  <div>
    <MypageCardTitle>お気に入りの練習問題</MypageCardTitle>

    <v-card
      class="mypage-bookmark-card pa-3 rounded-lg shadow-low"
      color="white"
    >
      <v-list v-if="bookmarkPractices.length">
        <AppPracticeListItem
          v-for="practice in bookmarkPractices"
          :key="practice.id"
          class="rounded-lg"
          :slug="practice.workSlug"
          :practice="practice"
          :logged-in="loggedIn"
          @remove-bookmark="$listeners['remove-bookmark']"
        />
      </v-list>
      <v-card-text
        v-else
        class="text-default pa-2"
      >
        お気に入りの練習問題はありません。
      </v-card-text>
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
  props: {
    bookmarkPractices: {
      type: Array,
      default: () => [],
    },
    loggedIn: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style lang="scss" scoped>
.mypage-bookmark-card {
  min-height: 300px;
}
</style>
