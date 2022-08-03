<template>
  <v-main :style="{ minHeight: minMainHeight }">
    <router-view :key="$route.path" />
    <BaseFlashMessage />
  </v-main>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'TheView',
  computed: {
    ...mapGetters('app', ['footerHeight']),
    minMainHeight() {
      return `calc(100vh - (${this.footerHeight}px))`
    },
  },
}
</script>
