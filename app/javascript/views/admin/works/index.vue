<template>
  <BaseContainerAdmin>
    <BasePageHeading title="問題集一覧" />

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
      :item="item"
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
      :items="displayItem"
      @show-edit-modal="showEditModal(item, activeTable)"
      @show-delete-modal="showDeleteModal(item, activeTable)"
    />
    <WorksDeleteModal
      :is-active.sync="isVisibleDeleteModal"
      :title="modalTitle"
      :items="displayItem"
      @delete="deleteItem(item, activeTable)"
    />
  </BaseContainerAdmin>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatDate } from '@/utils/format-date'
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
      isSorted: false,
      isVisibleCreateModal: false,
      isVisibleDetailModal: false,
      isVisibleEditModal: false,
      isVisibleDeleteModal: false,
      item: {},
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
          this.replace(this.works, res.data)
          this.buildList()
          this.closeEditModal()
          this.closeDetailModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async deleteWork(work) {
      await this.$axios.delete(`admin/works/${work.id}`, work).then(() => {
        this.works = this.pullAt(this.works, work)
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
          this.replace(this.chapters, res.data)
          this.buildList()
          this.closeEditModal()
          this.closeDetailModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async deleteChapter(chapter) {
      await this.$axios.delete(`admin/chapters/${chapter.id}`, { chapter: chapter }).then(() => {
        this.chapters = this.pullAt(this.chapters, chapter)
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
          this.replace(this.practices, res.data)
          this.buildList()
          this.closeEditModal()
          this.closeDetailModal()
        })
        .catch(err => (this.errorMessages = err.response.data))
    },
    async deletePractice(practice) {
      await this.$axios.delete(`admin/practices/${practice.id}`, { practice: practice }).then(() => {
        this.practices = this.pullAt(this.practices, practice)
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
        this.changeSortStatus()
      })
    },
    onSort(evt) {
      const table = evt.item.dataset.tableType
      const newSortedIds = this.getNodesIds(evt.to.childNodes)
      this.changeSortResult(newSortedIds, this.references[table], this.sortResults[table])
      this.changeSortStatus()
    },
    getNodesIds(array) {
      return Array.from(array, el => parseInt(el.dataset.id))
    },
    changeSortResult(ids, references, sortResults) {
      const index = references.findIndex(el => this.intersectionBy(el, ids).length)
      if (JSON.stringify(references[index]) !== JSON.stringify(ids)) {
        sortResults.splice(index, 1, ids)
      } else {
        sortResults.splice(index, 1)
      }
    },
    intersectionBy(array, values, key = null) {
      return array.filter(el => values.includes(el[key] || el))
    },
    changeSortStatus() {
      this.isSorted = this.existSortResult()
    },
    existSortResult() {
      return Object.values(this.sortResults).some(el => el.length)
    },
    resetOrder() {
      this.list = this.baseList
      this.resetSortResults()
      this.changeSortStatus()
    },
    pullAt(arr, target, key = 'id') {
      return arr.filter(el => el[key] !== target[key])
    },
    replace(arr, obj, key = 'id') {
      const item = arr.findIndex(el => el[key] === obj[key])
      arr.splice(item, 1, obj)
    },
    displayColumns(item, table) {
      item = cloneDeep(item)
      switch (table) {
        case this.tableType.works.id:
          delete item.chapters
          break
        case this.tableType.chapters.id:
          delete item.practices
          break
        case this.tableType.practices.id:
          ;[item.sampleDatabase, item.sampleTables] = this.findSampleDatabase(
            item.sampleDatabaseId,
            item.sampleTableIds
          )
          delete item.sampleDatabaseId
          delete item.sampleTableIds
          break
        default:
          break
      }
      return item
    },
    deleteItem(item, table) {
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
      const sampleTables = this.intersectionBy(sampleDatabase.tables, tableIds, 'id')

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
      this.item = item
      this.isVisibleDetailModal = true
    },
    closeDetailModal() {
      this.displayItem = {}
      this.item = {}
      this.isVisibleDetailModal = false
    },
    showEditModal(item, table) {
      this.changeActiveTable(table)
      item = cloneDeep(item)
      this.item = item
      this.isVisibleEditModal = true
    },
    closeEditModal() {
      this.item = {}
      this.isVisibleEditModal = false
    },
    showDeleteModal(item, table) {
      this.changeActiveTable(table)
      item = cloneDeep(item)
      item.createdAt = formatDate(item.createdAt)
      item.updatedAt = formatDate(item.updatedAt)
      this.displayItem = this.displayColumns(item, table)
      this.item = item
      this.isVisibleDeleteModal = true
    },
    closeDeleteModal() {
      this.displayItem = {}
      this.item = {}
      this.isVisibleDeleteModal = false
    },
  },
}
</script>
