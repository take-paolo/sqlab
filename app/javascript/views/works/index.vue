<template>
  <AppContainer
    v-if="works"
    class="works-container"
  >
    <v-row>
      <v-col>
        <AppPageHeading>問題集一覧</AppPageHeading>
      </v-col>
    </v-row>
    <v-row class="my-n5">
      <v-col
        v-for="work in works"
        :key="work.id"
        class="pa-5"
        cols="6"
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
  width: 85%;
  margin: 0 auto;
}
</style>
