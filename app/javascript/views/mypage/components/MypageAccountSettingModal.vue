<template>
  <BaseModal
    max-width="600px"
    :is-active="isActive"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>アカウント設定</template>

    <template #text>
      <div class="pa-6">
        <ValidationObserver
          v-slot="{ invalid }"
          ref="observer"
        >
          <form @submit.prevent="$emit('update', userEdit)">
            <ValidationProvider
              v-slot="{ errors }"
              class="form-control"
              vid="name"
              :name="$t('name')"
              tag="div"
              rules="required|max:32"
            >
              <v-text-field
                v-model="userEdit.name"
                hide-details="auto"
                :label="$t('name')"
                :error-messages="errors"
              />
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              class="form-control"
              vid="email"
              :name="$t('email')"
              tag="div"
              rules="required|email"
            >
              <v-text-field
                v-model="userEdit.email"
                type="email"
                hide-details="auto"
                :label="$t('email')"
                :error-messages="errors"
              />
            </ValidationProvider>

            <BaseButton
              class="mt-7"
              depressed
              type="submit"
              :disabled="invalid"
            >
              <slot>更新</slot>
            </BaseButton>
          </form>
        </ValidationObserver>

        <div class="d-block text-right">
          <a
            class="mypage-account-delete-btn mt-3 error--text"
            @click="$emit('show-account-delete-dialog')"
          >
            アカウント削除
          </a>
        </div>
      </div>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'MypageAccountSettingModal',
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    user: {
      type: Object,
      required: true,
    },
    errorMessages: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    userEdit: {
      get() {
        return this.user
      },
      set(val) {
        this.$emit('update:user', val)
      },
    },
  },
  watch: {
    errorMessages(newMessages) {
      Object.keys(newMessages).forEach(key => {
        newMessages[key] = this.$t(key) + newMessages[key]
      })
      this.$refs.observer.setErrors(newMessages)
    },
  },
}
</script>

<style lang="scss" scoped>
.mypage-account-delete-btn {
  &:hover {
    opacity: 0.5;
    transition: 0.3s cubic-bezier(0.25, 0.8, 0.5, 1);
  }
}
</style>
