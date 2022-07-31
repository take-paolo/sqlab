<template>
  <ValidationObserver
    v-slot="{ invalid }"
    ref="observer"
  >
    <form
      class="pa-6"
      @submit.prevent="$emit('submit', practice)"
    >
      <ValidationProvider
        v-slot="{ errors }"
        vid="chapterId"
        :name="$t('name')"
        rules="required"
        tag="div"
      >
        <v-select
          v-model="practice.chapterId"
          class="form-control"
          :items="chapters"
          item-value="id"
          item-text="name"
          :label="$t('chapterId')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="name"
        :name="$t('name')"
        rules="required"
        tag="div"
      >
        <v-text-field
          v-model="practice.name"
          class="form-control"
          :label="$t('name')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="question"
        :name="$t('question')"
        rules="required"
        tag="div"
      >
        <v-textarea
          v-model="practice.question"
          class="form-control"
          rows="3"
          :label="$t('question')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="answer"
        :name="$t('answer')"
        rules="required"
        tag="div"
      >
        <v-textarea
          v-model="practice.answer"
          class="form-control"
          rows="6"
          :label="$t('answer')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="sampleDatabaseId"
        :name="$t('sampleDatabase')"
        rules="required"
        tag="div"
      >
        <v-select
          v-model="practice.sampleDatabaseId"
          class="form-control"
          :items="sampleDatabases"
          item-value="id"
          item-text="name"
          :label="$t('sampleDatabase')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="sampleTableIds"
        :name="$t('sampleTables')"
        rules=""
        tag="div"
      >
        <v-select
          v-if="practice.sampleDatabaseId"
          v-model="practice.sampleTableIds"
          class="form-control"
          :items="sampleTables"
          item-value="id"
          item-text="name"
          multiple
          :label="$t('sampleTables')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="displayErDiagram"
        :name="$t('displayErDiagram')"
        rules=""
        tag="div"
      >
        <v-checkbox
          v-model="practice.displayErDiagram"
          class="form-control"
          :label="$t('displayErDiagram')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="enabled"
        :name="$t('enabled')"
        rules=""
        tag="div"
      >
        <v-checkbox
          v-model="practice.enabled"
          class="form-control"
          :label="$t('enabled')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="published"
        :name="$t('published')"
        rules=""
        tag="div"
      >
        <v-checkbox
          v-model="practice.published"
          class="form-control"
          :label="$t('published')"
          :error-messages="errors"
        />
      </ValidationProvider>
      <ValidationProvider
        v-slot="{ errors }"
        vid="requiresAuth"
        :name="$t('requiresAuth')"
        rules=""
        tag="div"
      >
        <v-checkbox
          v-model="practice.requiresAuth"
          class="form-control"
          :label="$t('requiresAuth')"
          :error-messages="errors"
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
  name: 'WorksFormPractice',
  props: {
    item: {
      type: Object,
      default: () => ({
        chapterId: null,
        name: '',
        question: '',
        answer: '',
        sampleDatabaseId: null,
        sampleTableIds: [],
        displayErDiagram: true,
        enabled: false,
        published: false,
        requiresAuth: true,
      }),
    },
    chapters: {
      type: Array,
      default: () => [],
    },
    sampleDatabases: {
      type: Array,
      default: () => [],
    },
    errorMessages: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    practice: {
      get() {
        return this.item
      },
      set(val) {
        this.$emit('update:item', val)
      },
    },
    sampleTables() {
      return this.sampleDatabases.find(database => database.id === this.practice.sampleDatabaseId).tables
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
