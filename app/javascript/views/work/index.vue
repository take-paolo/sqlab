<template>
  <div>
    <p>{{ work.name }}</p>
    <p>{{ work.description }}</p>
    <div>
      <div
        v-for="chapter in work.chapters"
        :key="chapter.id"
      >
        <span>{{ chapter.name }}</span>
        <ul>
          <li
            v-for="practice in chapter.practices"
            :key="practice.id"
          >
            <router-link :to="{ name: 'Practice', params: { slug: work.slug, id: practice.id } }">
              {{ practice.name }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'WorkView',
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
p {
  font-size: 2em;
  text-align: center;
}
</style>
