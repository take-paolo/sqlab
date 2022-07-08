<template>
  <div>
    <div
      class="practice-resizer"
      @mousedown="$emit('mousedown', $event)"
    />
  </div>
</template>

<script>
export default {
  name: 'PracticeResizer',
}
</script>

<style lang="scss" scoped>
.practice-resizer {
  cursor: col-resize;
  background: inherit;
  height: 100%;
}
</style>
