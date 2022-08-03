<template>
  <div>
    <TopMainVisual :concept="concept" />
    <TopAbout />
    <TopFeature :features="features" />
    <TopConcern />
    <TopFaq :faq="faq" />
    <TopCatch :concept="concept" />
  </div>
</template>

<script>
// data
import features from '@/data/features'
import faq from '@/data/faq'

// components
import TopMainVisual from './components/TopMainVisual'
import TopAbout from './components/TopAbout'
import TopFeature from './components/TopFeature'
import TopConcern from './components/TopConcern'
import TopFaq from './components/TopFaq'
import TopCatch from './components/TopCatch'

export default {
  name: 'TopView',
  components: {
    TopMainVisual,
    TopAbout,
    TopFeature,
    TopConcern,
    TopFaq,
    TopCatch,
  },
  data() {
    return {
      concept: 'SQLの知識をスキルに',
      features: features,
      faq: faq,
    }
  },
}
</script>
