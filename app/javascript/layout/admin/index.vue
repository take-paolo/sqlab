<template>
  <div>
    <TheSidebar />
    <TheView />
  </div>
</template>

<script>
import TheSidebar from './components/TheSidebar'
import TheView from './components/TheView'

export default {
  name: 'AdminLayout',
  components: {
    TheSidebar,
    TheView,
  },
}
</script>
