<template>
  <div>
    <p>問題集</p>
    <div
      v-for="work in works"
      :key="work.id"
    >
      <router-link :to="{ name: 'Work', params: { slug: work.slug } }">
        {{ work.name }}
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: 'WorksView',
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
p {
  font-size: 2em;
  text-align: center;
}
</style>
