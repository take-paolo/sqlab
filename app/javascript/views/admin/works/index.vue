<template>
  <AppContainerAdmin>
    <AppPageHeading class="mb-12">問題集一覧</AppPageHeading>

    <WorksList
      :list.sync="list"
      :table-type="tableType"
      @sort="onSort"
      @show-detail-modal="showDetailModal"
      @show-edit-modal="showEditModal"
      @show-delete-modal="showDeleteModal"
    />

    <WorksFooter
      :is-sorted="isSorted"
      :table-type="tableType"
      :style="{ marginLeft: adminSidebarWidth + 'px' }"
      @show-create-modal="showCreateModal"
      @update-order="updateOrder"
      @reset-order="resetOrder"
    />

    <WorksCreateModal
      :is-active.sync="isVisibleCreateModal"
      :table-type="tableType"
      :active-table="activeTable"
      :title="modalTitle"
      :works="works"
      :chapters="chapters"
      :sample-databases="sampleDatabases"
      :error-messages="errorMessages"
      @create-work="createWork"
      @create-chapter="createChapter"
      @create-practice="createPractice"
    />
    <WorksEditModal
      :is-active.sync="isVisibleEditModal"
      :table-type="tableType"
      :active-table="activeTable"
      :title="modalTitle"
      :item="itemEdit"
      :works="works"
      :chapters="chapters"
      :sample-databases="sampleDatabases"
      :error-messages="errorMessages"
      @update-work="updateWork"
      @update-chapter="updateChapter"
      @update-practice="updatePractice"
    />
    <WorksDetailModal
      :is-active.sync="isVisibleDetailModal"
      :title="modalTitle"
      :item="displayItem"
      @show-edit-modal="showEditModal(itemDetail, activeTable)"
      @show-delete-modal="showDeleteModal(itemDetail, activeTable)"
    />
    <WorksDeleteModal
      :is-active.sync="isVisibleDeleteModal"
      :title="modalTitle"
      @delete="handleDeleteItem(itemDelete, activeTable)"
      @cancel="closeDeleteModal"
    />
  </AppContainerAdmin>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatDate } from '@/utils/format-date'
import { intersectionBy, pullObjectFrom, replaceObjFrom } from '@/utils/helpers'
import cloneDeep from 'lodash.clonedeep'
import WorksList from './components/WorksList'
import WorksCreateModal from './components/WorksCreateModal'
import WorksEditModal from './components/WorksEditModal'
import WorksDetailModal from './components/WorksDetailModal'
import WorksDeleteModal from './components/WorksDeleteModal'
import WorksFooter from './components/WorksFooter'

export default {
  name: 'AdminWorks',
  components: {
    WorksList,
    WorksCreateModal,
    WorksEditModal,
    WorksDetailModal,
    WorksDeleteModal,
    WorksFooter,
  },
  data() {
    return {
      tableType: {
        works: {
          id: 'works',
          title: '問題集',
        },
        chapters: {
          id: 'chapters',
          title: 'チャプター',
        },
        practices: {
          id: 'practices',
          title: '練習問題',
        },
      },
      activeTable: '',
      works: [],
      chapters: [],
      practices: [],
      sampleDatabases: [],
      isVisibleCreateModal: false,
      isVisibleDetailModal: false,
      isVisibleEditModal: false,
      isVisibleDeleteModal: false,
      itemDetail: {},
      itemEdit: {},
      itemDelete: {},
      displayItem: {},
      references: {},
      sortResults: {},
      list: [],
      baseList: [],
      errorMessages: {},
    }
  },
  computed: {
    ...mapGetters('app', ['adminSidebarWidth']),
    modalTitle() {
      return this.tableType[this.activeTable]?.title || ''
    },
    isSorted() {
      return Object.values(this.sortResults).some(el => el.length)
    },
  },
  created() {
    this.setup()
  },
  methods: {
    async setup() {
      this.resetReferences()
      this.resetSortResults()
      await this.fetchWorks()
      await this.fetchChapters()
      await this.fetchPractices()
      this.fetchSampleDatabases()
      this.setReferences()
      this.buildList()
    },
    resetReferences() {
      Object.keys(this.tableType).forEach(key => {
        this.$set(this.references, this.tableType[key].id, [])
      })
    },
    resetSortResults() {
      Object.keys(this.tableType).forEach(key => {
        this.$set(this.sortResults, this.tableType[key].id, [])
      })
    },
    buildList() {
      this.list = this.works
      this.list.forEach(work => {
        const chapters = this.chapters.filter(chapter => chapter.workId === work.id)
        this.$set(work, 'chapters', chapters)

        work.chapters.forEach(chapter => {
          const practices = this.practices.filter(practice => practice.chapterId === chapter.id)
          this.$set(chapter, 'practices', practices)
        })
      })
      this.baseList = JSON.parse(JSON.stringify(this.list))
    },
    setReferences() {
      this.addReference(this.works, this.references[this.tableType.works.id])
      this.works.forEach(work => {
        let chapters = this.chapters.filter(chapter => chapter.workId === work.id)
        this.addReference(chapters, this.references[this.tableType.chapters.id])
      })
      this.chapters.forEach(chapter => {
        let practices = this.practices.filter(practice => practice.chapterId === chapter.id)
        this.addReference(practices, this.references[this.tableType.practices.id])
      })
    },
    addReference(array, references) {
      if (array.length) references.push(array.map(el => el.id))
    },
    async fetchWorks() {
      await this.$axios.get('admin/works').then(res => (this.works = res.data))
    },
    async fetchChapters() {
      await this.$axios.get('admin/chapters').then(res => (this.chapters = res.data))
    },
    async fetchPractices() {
      await this.$axios.get('admin/practices').then(res => (this.practices = res.data))
    },
    async fetchSampleDatabases() {
      await this.$axios.get('samples/databases').then(res => (this.sampleDatabases = res.data))
    },
    async createWork(work) {
      await this.$axios
        .post('admin/works', { work: work })
        .then(res => {
          this.works.push(res.data)
          this.buildList()
          this.closeCreateModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async updateWork(work) {
      await this.$axios
        .patch(`admin/works/${work.id}`, { work: work })
        .then(res => {
          replaceObjFrom(this.works, res.data)
          this.buildList()
          this.closeEditModal()
          this.closeDetailModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async deleteWork(work) {
      await this.$axios.delete(`admin/works/${work.id}`).then(() => {
        this.works = pullObjectFrom(this.works, work)
        this.buildList()
        this.closeDeleteModal()
        this.closeDetailModal()
      })
    },
    async createChapter(chapter) {
      await this.$axios
        .post('admin/chapters', { chapter: chapter })
        .then(res => {
          this.chapters.push(res.data)
          this.buildList()
          this.closeCreateModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async updateChapter(chapter) {
      await this.$axios
        .patch(`admin/chapters/${chapter.id}`, { chapter: chapter })
        .then(res => {
          replaceObjFrom(this.chapters, res.data)
          this.buildList()
          this.closeEditModal()
          this.closeDetailModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async deleteChapter(chapter) {
      await this.$axios.delete(`admin/chapters/${chapter.id}`).then(() => {
        this.chapters = pullObjectFrom(this.chapters, chapter)
        this.buildList()
        this.closeDeleteModal()
        this.closeDetailModal()
      })
    },
    async createPractice(practice) {
      practice = cloneDeep(practice)
      const sampleTables = practice.sampleTableIds
      delete practice.sampleTableIds

      await this.$axios
        .post('admin/practices', {
          practice: practice,
          sampleTables: sampleTables,
        })
        .then(res => {
          this.practices.push(res.data)
          this.buildList()
          this.closeCreateModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async updatePractice(practice) {
      practice = cloneDeep(practice)
      const sampleTables = practice.sampleTableIds
      delete practice.sampleTableIds

      await this.$axios
        .patch(`admin/practices/${practice.id}`, {
          practice: practice,
          sampleTables: sampleTables,
        })
        .then(res => {
          replaceObjFrom(this.practices, res.data)
          this.buildList()
          this.closeEditModal()
          this.closeDetailModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async deletePractice(practice) {
      await this.$axios.delete(`admin/practices/${practice.id}`).then(() => {
        this.practices = pullObjectFrom(this.practices, practice)
        this.buildList()
        this.closeDeleteModal()
        this.closeDetailModal()
      })
    },
    async updateOrder() {
      return Promise.all([
        this.$axios.patch('admin/works/order', {
          ids: this.sortResults[this.tableType.works.id],
        }),
        this.$axios.patch('admin/chapters/order', {
          ids: this.sortResults[this.tableType.chapters.id],
        }),
        this.$axios.patch('admin/practices/order', {
          ids: this.sortResults[this.tableType.practices.id],
        }),
      ]).then(() => {
        this.setup()
      })
    },
    onSort(evt) {
      const table = evt.item.dataset.tableType
      const newSortedIds = this.getNodesIds(evt.to.childNodes)
      this.changeSortResult(newSortedIds, this.references[table], this.sortResults[table])
    },
    getNodesIds(array) {
      return Array.from(array, el => parseInt(el.dataset.id))
    },
    changeSortResult(ids, references, sortResults) {
      const reference = references.find(el => intersectionBy(el, ids).length)
      const index = sortResults.findIndex(el => intersectionBy(el, ids).length)

      if (JSON.stringify(reference) !== JSON.stringify(ids)) {
        index !== -1 ? sortResults.splice(index, 1, ids) : sortResults.push(ids)
      } else {
        if (index !== -1) sortResults.splice(index, 1)
      }
    },
    resetOrder() {
      this.list = this.baseList
      this.resetSortResults()
    },
    displayColumns(obj, table) {
      obj = cloneDeep(obj)
      switch (table) {
        case this.tableType.works.id:
          delete obj.chapters
          break
        case this.tableType.chapters.id:
          delete obj.practices
          break
        case this.tableType.practices.id:
          ;[obj.sampleDatabase, obj.sampleTables] = this.findSampleDatabase(obj.sampleDatabaseId, obj.sampleTableIds)
          delete obj.sampleDatabaseId
          delete obj.sampleTableIds
          break
        default:
          break
      }
      return obj
    },
    handleDeleteItem(item, table) {
      switch (table) {
        case this.tableType.works.id:
          this.deleteWork(item)
          break
        case this.tableType.chapters.id:
          this.deleteChapter(item)
          break
        case this.tableType.practices.id:
          this.deletePractice(item)
          break
        default:
          break
      }
    },
    findSampleDatabase(databaseId, tableIds) {
      const sampleDatabase = this.sampleDatabases.find(database => database.id === databaseId)
      const sampleTables = intersectionBy(sampleDatabase.tables, tableIds, 'id')

      return [sampleDatabase.name, sampleTables.map(table => table.name).join(', ')]
    },
    changeActiveTable(table) {
      this.activeTable = table
    },
    showCreateModal(table) {
      this.changeActiveTable(table)
      this.isVisibleCreateModal = true
    },
    closeCreateModal() {
      this.isVisibleCreateModal = false
    },
    showDetailModal(item, table) {
      this.changeActiveTable(table)
      item = cloneDeep(item)
      item.createdAt = formatDate(item.createdAt)
      item.updatedAt = formatDate(item.updatedAt)
      this.displayItem = this.displayColumns(item, table)
      this.itemDetail = item
      this.isVisibleDetailModal = true
    },
    closeDetailModal() {
      this.displayItem = {}
      this.itemDetail = {}
      this.isVisibleDetailModal = false
    },
    showEditModal(item, table) {
      this.changeActiveTable(table)
      item = cloneDeep(item)
      this.itemEdit = item
      this.isVisibleEditModal = true
    },
    closeEditModal() {
      this.itemEdit = {}
      this.isVisibleEditModal = false
    },
    showDeleteModal(item, table) {
      this.changeActiveTable(table)
      this.itemDelete = item
      this.isVisibleDeleteModal = true
    },
    closeDeleteModal() {
      this.itemDelete = {}
      this.isVisibleDeleteModal = false
    },
  },
}
</script>
