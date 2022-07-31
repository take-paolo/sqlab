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
        vid="name"
        :name="$t('name')"
        tag="div"
        rules="required"
      >
        <v-text-field
          v-model="work.name"
          class="form-control"
          :error-messages="errors"
          :label="$t('name')"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="description"
        :name="$t('description')"
        tag="div"
        rules="required"
      >
        <v-textarea
          v-model="work.description"
          class="form-control"
          :error-messages="errors"
          :label="$t('description')"
          rows="3"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
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
          class="form-control"
          :error-messages="errors"
          :label="$t('slug')"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="enabled"
        :name="$t('enabled')"
        tag="div"
        rules=""
      >
        <v-checkbox
          v-model="work.enabled"
          class="form-control"
          :error-messages="errors"
          :label="$t('enabled')"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="published"
        :name="$t('published')"
        tag="div"
        rules=""
      >
        <v-checkbox
          v-model="work.published"
          class="form-control"
          :error-messages="errors"
          :label="$t('published')"
        />
      </ValidationProvider>

      <BaseButton
        class="mt-4"
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
