<template>
  <v-main>
    <router-view :key="$route.path" />
    <BaseFlashMessage />
  </v-main>
</template>

<script>
export default {
  name: 'TheView',
}
</script>
