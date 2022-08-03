<template>
  <ValidationObserver
    v-slot="{ invalid }"
    ref="observer"
  >
    <form
      class="pa-6"
      @submit.prevent="$emit('submit', work)"
    >
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="name"
        :name="$t('name')"
        tag="div"
        rules="required"
      >
        <v-text-field
          v-model="work.name"
          hide-details="auto"
          :label="$t('name')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="description"
        :name="$t('description')"
        tag="div"
        rules="required"
      >
        <v-textarea
          v-model="work.description"
          hide-details="auto"
          rows="3"
          :label="$t('description')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="slug"
        :name="$t('slug')"
        tag="div"
        :rules="{
          required: true,
          regex: /^[a-z_]+$/,
        }"
      >
        <v-text-field
          v-model="work.slug"
          hide-details="auto"
          :label="$t('slug')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="enabled"
        :name="$t('enabled')"
        tag="div"
        rules=""
      >
        <v-checkbox
          v-model="work.enabled"
          hide-details="auto"
          :label="$t('enabled')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        class="form-control"
        vid="published"
        :name="$t('published')"
        tag="div"
        rules=""
      >
        <v-checkbox
          v-model="work.published"
          hide-details="auto"
          :label="$t('published')"
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
  name: 'WorksFormWork',
  props: {
    item: {
      type: Object,
      default: () => ({
        name: '',
        description: '',
        slug: '',
        enabled: false,
        published: false,
      }),
    },
    errorMessages: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    work: {
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
