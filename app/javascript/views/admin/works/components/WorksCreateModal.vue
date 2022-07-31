<template>
  <BaseModal
    :is-active="isActive"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>{{ modalTitle }}</template>

    <template #text>
      <WorksFormWork
        v-if="activeTable === tableType.works.id && isActive"
        :error-messages="errorMessages"
        @submit="$listeners['create-work']"
      >
        作成
      </WorksFormWork>
      <WorksFormChapter
        v-if="activeTable === tableType.chapters.id && isActive"
        :works="works"
        :error-messages="errorMessages"
        @submit="$listeners['create-chapter']"
      >
        作成
      </WorksFormChapter>
      <WorksFormPractice
        v-if="activeTable === tableType.practices.id && isActive"
        :chapters="chapters"
        :sample-databases="sampleDatabases"
        :error-messages="errorMessages"
        @submit="$listeners['create-practice']"
      >
        作成
      </WorksFormPractice>
    </template>
  </BaseModal>
</template>

<script>
import WorksFormWork from './WorksFormWork'
import WorksFormChapter from './WorksFormChapter'
import WorksFormPractice from './WorksFormPractice'

export default {
  name: 'WorksCreateModal',
  components: {
    WorksFormWork,
    WorksFormChapter,
    WorksFormPractice,
  },
  props: {
    isActive: {
      type: Boolean,
      default: false,
    },
    tableType: {
      type: Object,
      required: true,
    },
    activeTable: {
      type: String,
      required: true,
    },
    title: {
      type: String,
      default: '',
    },
    works: {
      type: Array,
      default: () => [],
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
    modalTitle() {
      return this.title + '作成'
    },
  },
}
</script>
