<template>
  <div class="faq-section grey lighten-5">
    <TopSectionTitle>よくあるご質問</TopSectionTitle>

    <div class="faq-content mt-15">
      <v-expansion-panels
        hover
        multiple
        focusable
      >
        <v-expansion-panel
          v-for="(faqItem, index) in faq"
          :key="index"
          class="faq-expansion-panel rounded-lg overflow-hidden"
          :class="index !== 0 ? 'mt-5' : ''"
        >
          <v-expansion-panel-header class="faq-expansion-panel-header text-medium">
            {{ faqItem.header }}
          </v-expansion-panel-header>
          <v-expansion-panel-content class="text-pre-wrap text-medium">{{ faqItem.content }}</v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>
  </div>
</template>

<script>
import TopSectionTitle from './TopSectionTitle'

export default {
  name: 'TopFaq',
  components: {
    TopSectionTitle,
  },
  props: {
    faq: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
.faq-section {
  padding: 80px 16px 92px;
}
.faq-content {
  max-width: 900px;
  margin: 0 auto;
}
.faq-expansion-panel {
  box-shadow: 0px 0px 12px -4px var(--shadow-color);
  color: var(--v-font-base) !important;

  &::after {
    border-color: transparent !important;
  }
}
.faq-expansion-panel-header {
  line-height: normal !important;
}
</style>
