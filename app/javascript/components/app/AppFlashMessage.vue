<template>
  <v-alert
    v-if="flashMessageActive"
    class="app-flash-message shadow-low"
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
  name: 'AppFlashMessage',
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
.app-flash-message {
  position: fixed;
  top: 24px;
  right: 105px;
  z-index: 9999;
}
</style>
