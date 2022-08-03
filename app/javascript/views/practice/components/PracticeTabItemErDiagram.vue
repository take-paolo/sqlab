<template>
  <v-card
    height="100%"
    class="overflow-auto"
  >
    <template v-if="isDisplay">
      <div>
        <img
          :src="url"
          class="practice-er-diagram"
          alt="ER図"
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
    isDisplay: {
      type: Boolean,
      default: false,
    },
    url: {
      type: String,
      default: '',
    },
  },
  methods: {
    focus() {
      setTimeout(() => {
        this.$el.querySelector('.practice-er-diagram').focus()
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
