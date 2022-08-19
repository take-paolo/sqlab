<template>
  <v-list-item
    class="app-practice-list-item overflow-hidden px-4"
    :ripple="false"
    v-bind="$attrs"
    @click.stop="moveToPractice"
    v-on="$listeners"
  >
    <v-list-item-title class="py-3 font-weight-medium">
      {{ practice.name }}
    </v-list-item-title>

    <AppIconLock v-if="!loggedIn && practice.requiresAuth" />

    <AppIconBookmark
      v-if="loggedIn"
      :item="practice"
      @toggle-bookmark="handleBookmark"
    />
  </v-list-item>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'AppPracticeListItem',
  props: {
    slug: {
      type: String,
      default: '',
    },
    practice: {
      type: Object,
      default: () => ({}),
    },
    loggedIn: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    ...mapActions('works', ['toggleBookmark']),
    moveToPractice() {
      this.$router.push({
        name: 'Practice',
        params: {
          slug: this.slug,
          id: this.practice.id,
          requiresAuth: this.practice.requiresAuth,
        },
      })
    },
    handleBookmark(practice) {
      if (practice.bookmarked) {
        this.removeBookmark(practice.id)
        this.$emit('remove-bookmark', practice.id)
      } else {
        this.addBookmark(practice.id)
      }
    },
    addBookmark(id) {
      this.$axios.post('bookmarks', { practiceId: id }).then(() => this.toggleBookmark(id))
    },
    removeBookmark(id) {
      this.$axios.delete(`bookmarks/${id}`).then(() => this.toggleBookmark(id))
    },
  },
}
</script>

<style lang="scss" scoped>
.app-practice-list-item {
  z-index: 1;
}
</style>
