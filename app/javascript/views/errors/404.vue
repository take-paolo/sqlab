<template>
  <ErrorsContent img="page-not-found.svg">
    <template #title>404</template>
    <template #subtitle>Page Not Found</template>
    <template #text>お探しのページは見つかりませんでした。</template>
  </ErrorsContent>
</template>

<script>
import ErrorsContent from './components/ErrorsContent'

export default {
  name: 'PageNotFound',
  components: {
    ErrorsContent,
  },
}
</script>
