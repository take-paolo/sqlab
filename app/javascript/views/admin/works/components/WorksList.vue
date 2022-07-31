<template>
  <v-list class="works-list rounded-lg overflow-hidden">
    <VueDraggable
      v-model="works"
      @sort="$emit('sort', $event)"
    >
      <v-list-group
        v-for="work in works"
        :key="work.id"
        :data-id="work.id"
        :data-table-type="tableType.works.id"
        class="primary"
        color="white"
        :value="true"
        sub-group
        no-action
      >
        <template #activator>
          <WorksListItem
            :item="work"
            color="white"
            @show-detail-modal="$emit('show-detail-modal', work, tableType.works.id)"
            @show-edit-modal="$emit('show-edit-modal', work, tableType.works.id)"
            @show-delete-modal="$emit('show-delete-modal', work, tableType.works.id)"
          />
        </template>

        <VueDraggable
          v-model="work.chapters"
          @sort="$emit('sort', $event)"
        >
          <v-list-group
            v-for="chapter in work.chapters"
            :key="chapter.id"
            :data-id="chapter.id"
            :data-table-type="tableType.chapters.id"
            class="primary lighten-3"
            color="font"
            :value="true"
            sub-group
            no-action
          >
            <template #activator>
              <WorksListItem
                :item="chapter"
                @show-detail-modal="$emit('show-detail-modal', chapter, tableType.chapters.id)"
                @show-edit-modal="$emit('show-edit-modal', chapter, tableType.chapters.id)"
                @show-delete-modal="$emit('show-delete-modal', chapter, tableType.chapters.id)"
              />
            </template>

            <VueDraggable
              v-model="chapter.practices"
              class="white"
              @sort="$emit('sort', $event)"
            >
              <WorksListItem
                v-for="practice in chapter.practices"
                :key="practice.id"
                :data-id="practice.id"
                :data-table-type="tableType.practices.id"
                class="ml-4 pl-10"
                :item="practice"
                @show-detail-modal="$emit('show-detail-modal', practice, tableType.practices.id)"
                @show-edit-modal="$emit('show-edit-modal', practice, tableType.practices.id)"
                @show-delete-modal="$emit('show-delete-modal', practice, tableType.practices.id)"
              />
            </VueDraggable>
          </v-list-group>
        </VueDraggable>
      </v-list-group>
    </VueDraggable>
  </v-list>
</template>

<script>
import WorksListItem from './WorksListItem'

export default {
  name: 'WorksList',
  components: {
    WorksListItem,
  },
  props: {
    list: {
      type: Array,
      required: true,
    },
    tableType: {
      type: Object,
      required: true,
    },
  },
  computed: {
    works: {
      get() {
        return this.list
      },
      set(val) {
        this.$emit('update:list', val)
      },
    },
  },
}
</script>

<style lang="scss" scoped>
.works-list {
  margin-bottom: 72px;
  box-shadow: 0 0 15px -1px var(--shadow-color-low) !important;
}
</style>

<style lang="scss">
.works-list {
  .v-list-group__header__prepend-icon {
    margin-left: 1rem !important;
  }
  .v-list-group--sub-group {
    .v-list-group__header {
      padding-left: 0;
    }
    .v-list-group__items {
      .v-list-item {
        padding-left: 0;
      }
    }
  }
}
</style>
