<template>
  <div>
    <TheView />
    <TheSidebar />
  </div>
</template>

<script>
import TheView from './components/TheView'
import TheSidebar from './components/TheSidebar'

export default {
  name: 'AppLayout',
  components: {
    TheView,
    TheSidebar,
  },
}
</script>
