<template>
  <BaseModal
    :is-active="isActive"
    max-width="720px"
    @update:isActive="$listeners['update:isActive']"
  >
    <template #title>設定</template>

    <template #text>
      <div class="px-7 py-6">
        <BaseSwitch
          v-for="(preference, key, index) in preferences"
          :key="key"
          :class="index !== 0 ? 'mt-5' : ''"
          :input-value="preference.enabled"
          :label="preference.label"
          :messages="preference.description"
          @change="$emit('change', key)"
        />
      </div>
    </template>
  </BaseModal>
</template>

<script>
export default {
  name: 'PracticeModalPreferenceList',
  props: {
    isActive: {
      type: Boolean,
      required: true,
    },
    preferences: {
      type: Object,
      required: true,
    },
  },
}
</script>
