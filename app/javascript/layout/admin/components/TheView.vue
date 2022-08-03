<template>
  <v-main>
    <router-view :key="$route.path" />
    <AppFlashMessage />
  </v-main>
</template>

<script>
export default {
  name: 'TheView',
}
</script>
