<template>
  <ValidationObserver
    v-slot="{ invalid }"
    ref="observer"
  >
    <form
      class="pa-6"
      @submit.prevent="$emit('submit', chapter)"
    >
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="workId"
        :name="$t('workId')"
        rules="required"
        tag="div"
      >
        <v-select
          v-model="chapter.workId"
          :items="works"
          item-value="id"
          item-text="name"
          hide-details="auto"
          :label="$t('workId')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="name"
        :name="$t('name')"
        rules="required"
        tag="div"
      >
        <v-text-field
          v-model="chapter.name"
          hide-details="auto"
          :label="$t('name')"
          :error-messages="errors"
        />
      </ValidationProvider>

      <BaseButton
        class="mt-7"
        depressed
        type="submit"
        :disabled="invalid"
      >
        <slot>送信</slot>
      </BaseButton>
    </form>
  </ValidationObserver>
</template>

<script>
export default {
  name: 'WorksFormChapter',
  props: {
    item: {
      type: Object,
      default: () => ({
        workId: null,
        name: '',
      }),
    },
    works: {
      type: Array,
      default: () => [],
    },
    errorMessages: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    chapter: {
      get() {
        return this.item
      },
      set(val) {
        this.$emit('update:item', val)
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
