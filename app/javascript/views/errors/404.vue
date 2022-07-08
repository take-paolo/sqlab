<template>
  <div>
    <h1>404</h1>
    <router-link :to="{ name: 'Works' }">問題集一覧に戻る</router-link>
  </div>
</template>

<script>
export default {
  name: 'PageNotFound',
}
</script>
