<template>
  <v-card
    height="100%"
    class="overflow-auto"
  >
    <template v-if="url">
      <div>
        <img
          :src="url"
          class="practice-er-diagram"
          alt="ER diagram"
          tabindex="0"
        />
      </div>
    </template>
    <template v-else>
      <PracticeSheet class="d-flex align-center text-center">
        <BaseIcon>mdi-image-off-outline</BaseIcon>
      </PracticeSheet>
    </template>
  </v-card>
</template>

<script>
import PracticeSheet from './PracticeSheet'

export default {
  name: 'PracticeTabItemErDiagram',
  components: {
    PracticeSheet,
  },
  props: {
    url: {
      type: String,
      default: '',
    },
  },
  methods: {
    focus() {
      setTimeout(() => {
        if (this.url) {
          this.$el.querySelector('.practice-er-diagram').focus()
        }
      }, 1)
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-er-diagram {
  position: absolute;
  top: 0;
  left: 0;
}
</style>
