<template>
  <div class="main-visual-section">
    <v-row class="main-visual-content">
      <v-col
        class="text-center"
        cols="12"
      >
        <div>
          <BaseImage
            class="mx-auto"
            width="108px"
            eager
            :src="require('@/assets/logo.svg')"
            alt="SQLab"
          />
        </div>

        <h1 class="main-visual-concept mt-4">{{ concept }}</h1>

        <div class="mt-6">
          <BaseButton
            class="main-visual-btn px-5 text-default font-weight-bold primary--text rounded-lg"
            height="48px"
            color="white"
            depressed
            :to="{ name: 'Works' }"
          >
            問題を解いてみる
          </BaseButton>
        </div>

        <v-card
          class="main-visual-img-wrap"
          rounded="lg"
        >
          <BaseImage
            class="main-visual-img mx-auto"
            max-width="1540px"
            eager
            :src="require('@/assets/main-visual.png')"
            :srcset="`${require('@/assets/main-visual@2x.png')} 2x`"
            alt="演習画面"
          />
        </v-card>
      </v-col>
    </v-row>
    <TopMainVisualDecoration />
  </div>
</template>

<script>
import TopMainVisualDecoration from './TopMainVisualDecoration'

export default {
  name: 'TopMainVisual',
  components: {
    TopMainVisualDecoration,
  },
  props: {
    concept: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.main-visual-section {
  padding-top: 56px;
  position: relative;

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 500px;
    background: var(--v-primary-base);
  }
}
.main-visual-content {
  position: relative;
  z-index: 1;
}
.main-visual-concept {
  position: relative;
  font-size: 1.25rem;
  line-height: 2rem;
  color: white;
}
.main-visual-btn {
  position: relative;
  box-shadow: 0px 0px 10px -1px var(--shadow-color);
}
.main-visual-img-wrap {
  position: relative;
  width: 80%;
  margin: 64px auto 0;
  z-index: 1;
}
.main-visual-img {
  box-shadow: 0 1px 15px -2px var(--shadow-color) !important;
}
</style>
