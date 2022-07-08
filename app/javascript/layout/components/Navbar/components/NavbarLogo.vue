<template>
  <div>
    <BaseButton
      fab
      small
      depressed
      color="primary"
      :to="{ name: 'Top' }"
    >
      <BaseIcon color="white">mdi-flask-empty-outline</BaseIcon>
    </BaseButton>
  </div>
</template>

<script>
export default {
  name: 'NavbarLogo',
}
</script>
