<template>
  <AppContainer class="mypage-container">
    <v-row>
      <v-col>
        <AppPageHeading>マイページ</AppPageHeading>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="8">
        <MypageBookmark />
      </v-col>
      <v-col
        class="pl-10"
        cols="4"
      >
        <MypageClearCount />
        <MypageProfile
          class="mt-8"
          :user="user"
        />
      </v-col>
    </v-row>
  </AppContainer>
</template>

<script>
import { mapGetters } from 'vuex'

import MypageBookmark from './components/MypageBookmark'
import MypageClearCount from './components/MypageClearCount'
import MypageProfile from './components/MypageProfile'

export default {
  name: 'MypageView',
  components: {
    MypageBookmark,
    MypageClearCount,
    MypageProfile,
  },
  computed: {
    ...mapGetters('users', {
      user: 'authUser',
    }),
  },
}
</script>

<style lang="scss" scoped>
.mypage-container {
  width: 90%;
  max-width: 1400px;
  margin: 0 auto;
}
</style>
