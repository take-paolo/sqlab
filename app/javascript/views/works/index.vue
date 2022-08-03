<template>
  <AppContainer
    v-if="works"
    class="works-container"
  >
    <v-row>
      <v-col>
        <AppPageHeading>学習コンテンツ</AppPageHeading>
      </v-col>
    </v-row>
    <v-row>
      <v-col
        v-for="work in works"
        :key="work.id"
        cols="6"
        class="works-col pa-3"
      >
        <WorksCard :work="work" />
      </v-col>
    </v-row>
  </AppContainer>
</template>

<script>
import WorksCard from './components/WorksCard'

export default {
  name: 'WorksView',
  components: {
    WorksCard,
  },
  data() {
    return {
      works: [],
    }
  },
  created() {
    this.fetchWorks()
  },
  methods: {
    async fetchWorks() {
      await this.$axios
        .get('works')
        .then(res => (this.works = res.data))
        .catch(err => console.log(err))
    },
  },
}
</script>

<style lang="scss" scoped>
.works-container {
  width: 80%;
  margin: 0 auto;
}
.works-col {
  &:nth-of-type(1),
  &:nth-of-type(2) {
    padding-top: 0 !important;
  }
  &:nth-last-of-type(1),
  &:nth-last-of-type(2) {
    padding-bottom: 0 !important;
  }
}
</style>
