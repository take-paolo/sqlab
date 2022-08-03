<template>
  <BaseModal
    :is-active="isActive"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>{{ modalTitle }}</template>

    <template #text>
      <WorksFormWork
        v-if="activeTable === tableType.works.id"
        :item="item"
        :error-messages="errorMessages"
        @submit="$listeners['update-work']"
      >
        更新
      </WorksFormWork>
      <WorksFormChapter
        v-if="activeTable === tableType.chapters.id"
        :item="item"
        :works="works"
        :error-messages="errorMessages"
        @submit="$listeners['update-chapter']"
      >
        更新
      </WorksFormChapter>
      <WorksFormPractice
        v-if="activeTable === tableType.practices.id"
        :item="item"
        :chapters="chapters"
        :sample-databases="sampleDatabases"
        :error-messages="errorMessages"
        @submit="$listeners['update-practice']"
      >
        更新
      </WorksFormPractice>
    </template>
  </BaseModal>
</template>

<script>
import WorksFormWork from './WorksFormWork'
import WorksFormChapter from './WorksFormChapter'
import WorksFormPractice from './WorksFormPractice'

export default {
  name: 'WorksEditModal',
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
    item: {
      type: Object,
      required: true,
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
      return this.title + '編集'
    },
  },
}
</script>
