<template>
  <div class="login-form rounded-lg">
    <ValidationObserver
      v-slot="{ invalid, reset }"
      ref="observer"
    >
      <form
        class="pa-8"
        @submit.prevent="$emit('login', user)"
        @reset.prevent="reset"
      >
        <ValidationProvider
          v-slot="{ errors }"
          class="form-control"
          vid="email"
          :name="$t('email')"
          tag="div"
          rules="required|email"
        >
          <v-text-field
            v-model="user.email"
            type="email"
            hide-details="auto"
            :error-messages="errors"
            :label="$t('email')"
          />
        </ValidationProvider>
        <ValidationProvider
          v-slot="{ errors }"
          class="form-control"
          vid="password"
          :name="$t('password')"
          tag="div"
          rules="required|min:8"
        >
          <v-text-field
            v-model="user.password"
            type="password"
            hide-details="auto"
            :error-messages="errors"
            :label="$t('password')"
          />
        </ValidationProvider>

        <BaseButton
          class="d-block mt-7 mx-auto text-default"
          width="100%"
          height="44px"
          depressed
          type="submit"
          :disabled="invalid"
        >
          <slot>ログイン</slot>
        </BaseButton>
      </form>
    </ValidationObserver>
  </div>
</template>

<script>
export default {
  name: 'LoginForm',
  props: {
    item: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    user: {
      get() {
        return this.item
      },
      set(val) {
        this.$emit('update:item', val)
      },
    },
  },
  methods: {
    resetForm() {
      this.$refs.observer.reset()
    },
  },
}
</script>

<style lang="scss" scoped>
.login-form {
  max-width: 450px;
  width: 100%;
  margin: 0 auto;
  background: white;
  box-shadow: var(--shadow-low);
}
</style>
