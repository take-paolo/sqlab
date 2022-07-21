<template>
  <ErrorsContent img="internal-server-error.svg">
    <template #title>500</template>
    <template #subtitle>Internal Server Error</template>
    <template #text>
      システムエラーが発生しました。<br />
      お手数ですが、しばらく時間をおいてから再度お試しください。
    </template>
  </ErrorsContent>
</template>

<script>
import ErrorsContent from './components/ErrorsContent'

export default {
  name: 'InternalServerError',
  components: {
    ErrorsContent,
  },
}
</script>
