<template>
  <v-subheader class="work-drawer__chapter text-default font-weight-bold">
    <BaseIcon
      small
      color="primary"
    >
      mdi-rhombus-medium
    </BaseIcon>
    <span class="font--text">{{ name }}</span>
  </v-subheader>
</template>

<script>
export default {
  name: 'WorkDrawerChapter',
  props: {
    name: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.work-drawer__chapter {
  padding: 0;
  margin-bottom: 8px;
  height: auto;
}
</style>
