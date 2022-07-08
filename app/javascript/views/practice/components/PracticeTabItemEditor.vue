<template>
  <v-card height="100%">
    <PracticeEditor
      id="practice-editor"
      ref="practiceEditor"
      :value="query"
      @change="$listeners['change']"
    />
  </v-card>
</template>

<script>
import PracticeEditor from './PracticeEditor'

export default {
  name: 'PracticeTabItemEditor',
  components: {
    PracticeEditor,
  },
  props: {
    query: {
      type: String,
      default: '',
    },
  },
  methods: {
    setValue() {
      this.$refs.practiceEditor.setValue()
    },
    resetValue() {
      this.$refs.practiceEditor.resetValue()
    },
    focus() {
      this.$refs.practiceEditor.focus()
    },
  },
}
</script>
