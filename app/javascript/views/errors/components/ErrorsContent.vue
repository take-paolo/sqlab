<template>
  <div class="error-content">
    <div class="text-center">
      <h1 class="error-content-title">
        <slot name="title" />
      </h1>
      <p class="error-content-subtitle">
        <slot name="subtitle" />
      </p>
      <p class="font--text text-large mt-6">
        <slot name="text" />
      </p>
      <BaseButton
        class="error-content-btn text-default mt-4 px-4"
        height="52px"
        :to="{ name: 'Top' }"
      >
        トップページに戻る
      </BaseButton>
    </div>

    <div class="ml-10">
      <BaseImage
        class="mx-auto text-large font-weight-bold"
        max-width="500px"
        eager
        :src="require(`@/assets/${img}`)"
        alt=""
      />
    </div>
  </div>
</template>

<script>
export default {
  name: 'ErrorsContent',
  props: {
    img: {
      type: String,
      required: true,
    },
  },
}
</script>

<style lang="scss" scoped>
.error-content {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2%;
  max-width: 100%;
  max-height: 100vh;
  width: 100%;
  height: 100%;
}
.error-content-title {
  font-size: 7.5rem;
  font-weight: 900;
  color: var(--v-primary-base);
  line-height: normal;
}
.error-content-subtitle {
  font-size: 3rem;
  font-weight: 900;
  color: var(--v-font-darken1);
  line-height: normal;
  margin: 0;
}
.error-content-btn {
  box-shadow: var(--shadow-low) !important;
}
</style>
