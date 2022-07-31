<template>
  <v-footer
    class="works-footer"
    fixed
  >
    <div class="d-flex justify-space-between">
      <WorksFooterButton @click="$emit('show-create-modal', tableType.works.id)">問題集</WorksFooterButton>

      <WorksFooterButton @click="$emit('show-create-modal', tableType.chapters.id)">チャプター</WorksFooterButton>

      <WorksFooterButton @click="$emit('show-create-modal', tableType.practices.id)">練習問題</WorksFooterButton>

      <v-spacer></v-spacer>

      <WorksFooterButton
        :disabled="!isSorted"
        color="green lighten-4 green--text text--darken-1"
        icon="mdi-autorenew"
        @click="$emit('update-order')"
      >
        並び順変更
      </WorksFooterButton>

      <WorksFooterButton
        :disabled="!isSorted"
        color="grey lighten-3 font--text"
        icon="mdi-refresh"
        @click="$emit('reset-order')"
      >
        変更取り消し
      </WorksFooterButton>
    </div>
  </v-footer>
</template>

<script>
import WorksFooterButton from './WorksFooterButton'

export default {
  name: 'WorksFooter',
  components: {
    WorksFooterButton,
  },
  props: {
    isSorted: {
      type: Boolean,
      default: false,
    },
    tableType: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style lang="scss" scoped>
.works-footer {
  box-shadow: 0px 0px 6px -2px var(--shadow-color-low) !important;
  background: white;
  display: block;
  padding: 1rem;
}
</style>
