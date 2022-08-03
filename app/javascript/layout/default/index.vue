<template>
  <div>
    <TheSidebar />
    <TheView />
    <TheFooter />
  </div>
</template>

<script>
import TheSidebar from './components/TheSidebar'
import TheView from './components/TheView'
import TheFooter from './components/TheFooter'

export default {
  name: 'DefaultLayout',
  components: {
    TheSidebar,
    TheView,
    TheFooter,
  },
}
</script>
