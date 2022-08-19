<template>
  <AppContainer
    v-if="work"
    class="work-container"
  >
    <v-row>
      <v-col>
        <AppPageHeading>{{ work.name }}</AppPageHeading>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="7">
        <WorkList
          :work="work"
          :logged-in="loggedIn"
        />
      </v-col>
      <v-col
        class="pl-10"
        cols="5"
      >
        <WorkDetail :work="work" />
      </v-col>
    </v-row>
  </AppContainer>
</template>

<script>
import store from '@/store/index'
import { mapGetters, mapActions } from 'vuex'

import WorkList from './components/WorkList'
import WorkDetail from './components/WorkDetail'

export default {
  name: 'WorkView',
  components: {
    WorkList,
    WorkDetail,
  },
  beforeRouteEnter(to, from, next) {
    store.dispatch('works/fetchWork', to.params.slug).then(() => next())
  },
  computed: {
    ...mapGetters('works', ['work']),
    ...mapGetters('users', ['authUser']),
    loggedIn() {
      return Boolean(this.authUser)
    },
  },
  created() {
    this.fetchWork(this.$route.params.slug)
  },
  methods: {
    ...mapActions('works', ['fetchWork']),
  },
}
</script>

<style lang="scss" scoped>
.work-container {
  width: 90%;
  margin: 0 auto;
}
</style>
