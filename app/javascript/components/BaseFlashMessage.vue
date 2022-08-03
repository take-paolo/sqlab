<template>
  <v-alert
    v-if="flashMessageActive"
    class="base-flash-message"
    :type="flashMessage.type"
    :icon="flashMessage.icon"
    transition="slide-y-transition"
  >
    {{ flashMessage.text }}
  </v-alert>
</template>

<script>
import { mapGetters } from 'vuex'
import flashMessages from '@/data/flash-messages'

export default {
  name: 'BaseFlashMessage',
  inheritAttrs: false,
  data() {
    return {
      flashMessages: flashMessages,
    }
  },
  computed: {
    ...mapGetters('app', ['flashMessageActive', 'flashMessageType']),
    flashMessage() {
      return this.flashMessages[this.flashMessageType]
    },
  },
}
</script>

<style lang="scss" scoped>
.base-flash-message {
  position: absolute;
  top: 24px;
  right: 32px;
  z-index: 9999;
  box-shadow: var(--shadow-low) !important;
}
</style>
