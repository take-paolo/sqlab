<template>
  <BaseContainer>
    <template v-if="work">
      <v-row no-gutters>
        <v-col>
          <WorkHeading :title="work.name" />
        </v-col>
      </v-row>
      <v-row no-gutters>
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
    </template>
  </BaseContainer>
</template>

<script>
import store from '@/store/index'
import { mapGetters, mapActions } from 'vuex'

import WorkHeading from './components/WorkHeading'
import WorkMenu from './components/WorkMenu'
import WorkDetail from './components/WorkDetail'

export default {
  name: 'WorkView',
  components: {
    WorkHeading,
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
.work-col {
  padding: 0 2% !important;
}
</style>
