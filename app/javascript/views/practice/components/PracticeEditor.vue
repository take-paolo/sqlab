<template>
  <textarea :id="id" />
</template>

<script>
import { createEditor, removeKeyMaps } from '@/utils/codemirror'

export default {
  name: 'PracticeEditor',
  props: {
    id: {
      type: String,
      required: true,
    },
    value: {
      type: String,
      default: '',
    },
    readOnly: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      editor: null,
    }
  },
  mounted() {
    this.editor = createEditor(this.id, this.readOnly)
    removeKeyMaps(this.editor)
    this.editor.setValue(this.value)

    let that = this
    this.editor.on('change', function (cm) {
      that.$emit('change', cm.getValue())
    })

    setTimeout(() => {
      this.editor.refresh()
      this.editor.focus()
    }, 350)
  },
  methods: {
    setValue() {
      setTimeout(() => this.editor.setValue(this.value), 1)
    },
    resetValue() {
      setTimeout(() => this.editor.setValue(''), 1)
    },
    focus() {
      setTimeout(() => this.editor.focus(), 100)
    },
  },
}
</script>

<style lang="scss">
.cm-s-mbo {
  &.CodeMirror {
    font-size: 1rem;
    line-height: 1.5;
    letter-spacing: normal;
    height: 100%;
    font-family: Roboto, 'Noto Sans JP', sans-serif;
  }
  .CodeMirror-linenumbers {
    width: 40px;
  }
  .CodeMirror-linenumber {
    text-align: center;
    color: #757575;
  }
  .CodeMirror-gutters {
    background: #2c2c2c;
  }
}
</style>
