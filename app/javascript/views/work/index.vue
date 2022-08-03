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
      <v-col
        class="work-col"
        cols="8"
      >
        <WorkMenu :work="work" />
      </v-col>
      <v-col
        class="work-col"
        cols="4"
      >
        <WorkDetail :work="work" />
      </v-col>
    </v-row>
  </AppContainer>
</template>

<script>
import store from '@/store/index'
import { mapGetters, mapActions } from 'vuex'

import WorkMenu from './components/WorkMenu'
import WorkDetail from './components/WorkDetail'

export default {
  name: 'WorkView',
  components: {
    WorkMenu,
    WorkDetail,
  },
  beforeRouteEnter(to, from, next) {
    store.dispatch('works/fetchWork', to.params.slug).then(() => next())
  },
  computed: {
    ...mapGetters('works', ['work']),
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
  width: 95%;
  margin: 0 auto;
}
.work-col {
  padding: 0 2% !important;
}
</style>
