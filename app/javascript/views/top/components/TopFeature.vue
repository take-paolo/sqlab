<template>
  <div class="feature-section grey lighten-5">
    <TopSectionTitle>特徴</TopSectionTitle>

    <div class="feature-list-wrap mt-7">
      <template v-for="(feature, index) in features">
        <v-card
          :key="index"
          class="feature-item"
          :class="index % 2 === 0 ? 'flex-row-reverse' : ''"
        >
          <div :class="index % 2 === 0 ? 'ml-10' : 'mr-10'">
            <v-card-title class="feature-item__title">
              {{ feature.title }}
            </v-card-title>
            <BaseImage
              class="feature-item__icon"
              :class="index % 2 !== 0 ? 'feature-item__icon--reverse' : ''"
              max-width="168px"
              eager
              :src="require(`@/assets/${feature.icon}`)"
              alt=""
            />
          </div>
          <div class="mt-8">
            <v-card-text class="feature-item__text text-default text-pre-wrap">{{ feature.text }}</v-card-text>
          </div>
        </v-card>
      </template>
    </div>
  </div>
</template>

<script>
import TopSectionTitle from './TopSectionTitle'

export default {
  name: 'TopFeature',
  components: {
    TopSectionTitle,
  },
  props: {
    features: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
.feature-section {
  padding: 80px 16px 128px;
}
.feature-list-wrap {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.feature-item {
  display: flex;
  align-items: flex-start;

  &:not(:first-child) {
    margin-top: 72px;
  }
  > div {
    position: relative;
  }
}
.feature-item__title {
  width: 140px;
  height: 140px;
  border-radius: 50% !important;
  color: white;
  background: var(--v-primary-base);
  box-shadow: 0px 0px 12px -1px var(--shadow-color);
  justify-content: center;
}
.feature-item__text {
  max-width: 350px;
}
.feature-item__icon {
  max-width: 168px;
  position: absolute;
  top: 68%;
  left: 33%;

  &--reverse {
    left: -49%;
  }
}
</style>
