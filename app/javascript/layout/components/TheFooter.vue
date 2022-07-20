<template>
  <v-footer
    v-if="!isPracticePage"
    class="app-footer px-4 py-6"
    color="white"
    :style="{ marginRight: sidebarWidth + 'px' }"
  >
    <v-row class="text-center">
      <v-col cols="12">
        <BaseImage
          class="mx-auto"
          width="88px"
          eager
          :src="require('@/assets/logo-dark.svg')"
          alt="SQLab"
        />
      </v-col>

      <v-col cols="12">
        <BaseButtonText :to="{ name: 'Terms' }">利用規約</BaseButtonText>
        <BaseButtonText :to="{ name: 'Privacy' }">プライバシーポリシー</BaseButtonText>
        <BaseButtonText
          href="https://twitter.com/sqlab_app"
          target="_blank"
          rel="noopener"
        >
          Twitter
        </BaseButtonText>
      </v-col>

      <v-col cols="12">
        <small class="font--text text--darken-1">&copy; 2022 SQLab</small>
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'TheFooter',
  computed: {
    ...mapGetters('app', ['sidebarWidth', 'isPracticePage']),
  },
  mounted() {
    this.$nextTick(() => {
      this.updateFooterHeight(this.$el.clientHeight)
    })
  },
  methods: {
    ...mapActions('app', ['updateFooterHeight']),
  },
}
</script>

<style lang="scss" scoped>
.app-footer {
  box-shadow: 0px 0px 5px -2px var(--shadow-color) !important;
}
</style>
