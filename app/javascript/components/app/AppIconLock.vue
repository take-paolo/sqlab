<template>
  <v-list-item-icon class="ml-6 align-self-center">
    <v-tooltip
      top
      content-class="shadow"
      z-index="999"
      color="primary"
    >
      <template #activator="{ on, attrs }">
        <BaseIcon
          v-bind="attrs"
          v-on="on"
        >
          mdi-lock
        </BaseIcon>
      </template>
      <span>要ログイン</span>
    </v-tooltip>
  </v-list-item-icon>
</template>

<script>
export default {
  name: 'AppIconLock',
}
</script>
