<template>
  <div>
    <div class="practice-container">
      <div
        class="practice-content"
        :style="{ gridTemplateColumns: `${resizableColumn} 12px 1fr` }"
      >
        <PracticeQuestion
          class="practice-question-wrap shadow"
          :question="practice.question"
        />

        <PracticeTabs
          ref="inputTabs"
          class="practice-tabs-wrap--left"
          :active-tab.sync="activeInputTab"
        >
          <template #tabs>
            <BaseTab
              v-for="(inputTab, index) in inputTabs"
              :key="index"
              class="practice-tab"
              :href="anchorTag(inputTab.value)"
            >
              {{ inputTab.name }}
            </BaseTab>
          </template>

          <template #tabs-items>
            <BaseTabItem :value="inputTabs.editor.value">
              <PracticeTabItemEditor
                :ref="camelCase(inputTabs.editor.value)"
                :query="query"
                @change="updateQuery"
              />
            </BaseTabItem>

            <BaseTabItem :value="inputTabs.execResultModel.value">
              <PracticeTabItemExecResult
                :ref="camelCase(inputTabs.execResultModel.value)"
                :active-tab.sync="activeExecResultModelTab"
                :status="execResultModel.status"
                :values="execResultModel.values"
              />
            </BaseTabItem>
          </template>

          <PracticeToolbarEditor
            :is-processing="isQueryProcessing"
            @execute-query="executeQuery"
            @reset-editor="resetEditor"
          />
        </PracticeTabs>

        <PracticeResizer
          class="practice-resizer-wrap"
          @mousedown="onMouseDown"
        />

        <PracticeTabs
          ref="outputTabs"
          class="practice-tabs-wrap--right"
          :active-tab.sync="activeOutputTab"
        >
          <template #tabs>
            <BaseTab
              v-for="(outputTab, index) in outputTabs"
              :key="index"
              class="practice-tab"
              :href="anchorTag(outputTab.value)"
            >
              {{ outputTab.name }}
            </BaseTab>
          </template>

          <template #tabs-items>
            <BaseTabItem :value="outputTabs.sampleDatabase.value">
              <PracticeTabItemSampleDatabase
                :ref="camelCase(outputTabs.sampleDatabase.value)"
                :active-tab.sync="activeSampleTableTab"
                :tables="sampleTables"
              />
            </BaseTabItem>

            <BaseTabItem :value="outputTabs.erDiagram.value">
              <PracticeTabItemErDiagram
                :ref="camelCase(outputTabs.erDiagram.value)"
                :is-display="practice.displayErDiagram"
                :url="sampleDatabase.erDiagram"
              />
            </BaseTabItem>

            <BaseTabItem :value="outputTabs.execResult.value">
              <PracticeTabItemExecResult
                :ref="camelCase(outputTabs.execResult.value)"
                :active-tab.sync="activeExecResultTab"
                :is-processing="isQueryProcessing"
                :status="execResult.status"
                :values="execResult.values"
              />
            </BaseTabItem>
          </template>
        </PracticeTabs>
      </div>

      <PracticeFooter
        class="practice-footer"
        :is-processing="isQueryProcessing"
        @test-query="handleTestQuery"
        @open-example-answer-modal="openExampleAnswerModal"
        @open-preference-list-modal="openPreferenceListModal"
        @open-shortcut-list-modal="openShortcutListModal"
      />
    </div>

    <PracticeMenuErDiagram
      v-if="practice.displayErDiagram"
      :activator="erDiagramMenu"
      :url="sampleDatabase.erDiagram"
    />

    <PracticeModalTestResult
      :is-active.sync="isTestResultModalActive"
      :practice="practice"
      :result="testResult"
      @open-example-answer-modal="openExampleAnswerModal"
      @move-next-practice="moveNextPractice"
    />

    <PracticeModalExampleAnswer
      :is-active.sync="isExampleAnswerModalActive"
      :answer="practice.answer"
    />

    <PracticeModalPreferenceList
      :is-active.sync="isPreferenceListModalActive"
      :preferences="preferences"
      @change="togglePreference"
    />

    <PracticeModalShortcutList
      :is-active.sync="isShortcutListModalActive"
      :shortcuts="shortcuts"
    />
  </div>
</template>

<script>
import store from '@/store/index'
import { mapGetters, mapActions } from 'vuex'
import { isEmpty, anchorTag, camelCase } from '@/utils/helpers'
import { handleException } from '@/utils/exception'

// data
import judgement from '@/data/judgement'
import shortcuts from '@/data/shortcuts'
import preferences from '@/data/preferences'
import keyboardEvents from '@/data/keyboard-events'

// components
import PracticeQuestion from './components/PracticeQuestion'
import PracticeTabs from './components/PracticeTabs'
import PracticeTabItemEditor from './components/PracticeTabItemEditor'
import PracticeTabItemSampleDatabase from './components/PracticeTabItemSampleDatabase'
import PracticeTabItemErDiagram from './components/PracticeTabItemErDiagram'
import PracticeTabItemExecResult from './components/PracticeTabItemExecResult'
import PracticeResizer from './components/PracticeResizer'
import PracticeFooter from './components/PracticeFooter'
import PracticeMenuErDiagram from './components/PracticeMenuErDiagram'
import PracticeToolbarEditor from './components/PracticeToolbarEditor'
import PracticeModalTestResult from './components/PracticeModalTestResult'
import PracticeModalExampleAnswer from './components/PracticeModalExampleAnswer'
import PracticeModalPreferenceList from './components/PracticeModalPreferenceList'
import PracticeModalShortcutList from './components/PracticeModalShortcutList'

export default {
  name: 'PracticeView',
  components: {
    PracticeQuestion,
    PracticeTabs,
    PracticeTabItemEditor,
    PracticeTabItemSampleDatabase,
    PracticeTabItemErDiagram,
    PracticeTabItemExecResult,
    PracticeResizer,
    PracticeFooter,
    PracticeMenuErDiagram,
    PracticeToolbarEditor,
    PracticeModalTestResult,
    PracticeModalExampleAnswer,
    PracticeModalPreferenceList,
    PracticeModalShortcutList,
  },
  beforeRouteEnter(to, from, next) {
    store.dispatch('users/getAuthUser').then(authUser => {
      if (to.params.requiresAuth && !authUser) {
        next(false)
        store.dispatch('app/switchLoginModal', true)
        store.dispatch('app/openFlashMessage', 'loginWarning')
      } else {
        store.dispatch('practices/fetchPractice', to.params.id).then(() => next())
      }
    })
  },
  beforeRouteUpdate(to, from, next) {
    this.saveQuery()
    this.savePreferences()

    if (!to.params.requiresAuth) return next()
    store.dispatch('users/getAuthUser').then(authUser => {
      if (to.params.requiresAuth && !authUser) {
        next(false)
        store.dispatch('app/switchLoginModal', true)
        store.dispatch('app/openFlashMessage', 'loginWarning')
      } else {
        next()
      }
    })
  },
  beforeRouteLeave(to, from, next) {
    this.saveQuery()
    this.savePreferences()
    next()
  },
  data() {
    return {
      query: '',
      execResultModel: {},
      execResult: {
        status: null,
        values: '',
      },
      testResult: {},
      queryProcessing: false,
      sampleDatabase: {},
      sampleTables: [],
      isTestResultModalActive: false,
      isExampleAnswerModalActive: false,
      isPreferenceListModalActive: false,
      isShortcutListModalActive: false,
      activeInputTab: null,
      activeOutputTab: null,
      activeExecResultTab: 0,
      activeExecResultModelTab: 0,
      activeSampleTableTab: 0,
      resizableColumn: '1fr',
      contentWidth: '',
      offsetX: '',
      erDiagramMenu: null,
      inputTabs: {
        editor: {
          value: 'editor-tab',
          name: 'エディタ',
        },
        execResultModel: {
          value: 'exec-result-model-tab',
          name: '見本',
        },
      },
      outputTabs: {
        sampleDatabase: {
          value: 'sample-database-tab',
          name: 'データベース',
        },
        erDiagram: {
          value: 'er-diagram-tab',
          name: 'ER図',
        },
        execResult: {
          value: 'exec-result-tab',
          name: '実行結果',
        },
      },
      judgement: judgement,
      shortcuts: shortcuts,
      preferences: preferences,
      keyboardEvents: keyboardEvents,
    }
  },
  computed: {
    ...mapGetters('response', ['status']),
    ...mapGetters('works', ['work']),
    ...mapGetters('practices', ['practice']),
    isQueryProcessing() {
      return this.queryProcessing
    },
  },
  watch: {
    activeInputTab() {
      setTimeout(() => {
        this.$refs[this.camelCase(this.activeInputTab)].focus()
      }, 1)
    },
    activeOutputTab() {
      setTimeout(() => {
        this.$refs[this.camelCase(this.activeOutputTab)].focus()
      }, 1)
    },
    activeSampleTableTab() {
      setTimeout(() => {
        this.$refs[this.camelCase(this.outputTabs.sampleDatabase.value)].focus()
      }, 1)
    },
    activeExecResultTab() {
      setTimeout(() => {
        this.$refs[this.camelCase(this.outputTabs.execResult.value)].focus()
      }, 1)
    },
  },
  created() {
    this.initPractice(this.$route.params.slug, this.$route.params.id)
  },
  beforeMount() {
    document.addEventListener('keydown', this.handleKeyboardEvent)
    window.addEventListener('resize', this.calcContentWidth)
    window.addEventListener('beforeunload', this.saveQuery)
    window.addEventListener('beforeunload', this.savePreferences)
  },
  mounted() {
    this.$nextTick(() => {
      this.setErDiagramMenuActivator()
      this.calcOffsetX()
      this.calcContentWidth()
    })
  },
  beforeDestroy() {
    document.removeEventListener('keydown', this.handleKeyboardEvent)
    window.removeEventListener('resize', this.calcContentWidth)
    window.removeEventListener('beforeunload', this.saveQuery)
    window.removeEventListener('beforeunload', this.savePreferences)
  },
  methods: {
    anchorTag,
    camelCase,
    async initPractice(slug, id) {
      await this.fetchWork(slug)
      await this.fetchPractice(id)

      await this.fetchSampleData()

      this.loadQuery()
      this.loadPreferences()
      this.focusEditor()
    },
    ...mapActions('works', ['fetchWork']),
    ...mapActions('practices', ['fetchPractice']),
    async fetchSampleData() {
      await this.fetchSampleDatabase()
      await this.fetchSampleTables()
      await this.executeExampleAnswerQuery()
    },
    async fetchSampleDatabase() {
      await this.$axios
        .get(`samples/databases/${this.practice.sampleDatabaseId}`)
        .then(res => (this.sampleDatabase = res.data))
        .catch(err => handleException(err, this.$route.path))
    },
    async fetchSampleTables() {
      if (isEmpty(this.practice.sampleTableIds)) return

      await this.$axios
        .get(`samples/databases/${this.practice.sampleDatabaseId}/tables`, {
          params: {
            tableIds: this.practice.sampleTableIds,
          },
        })
        .then(res => (this.sampleTables = res.data))
        .catch(err => handleException(err, this.$route.path))
    },
    async executeExampleAnswerQuery() {
      this.execResultModel = await this.execute(this.practice.answer)
    },
    async execute(query) {
      let result = { status: null, values: '' }
      if (isEmpty(query)) return result

      this.startProcessing()
      await this.$axios
        .post(`samples/databases/${this.practice.sampleDatabaseId}/sql`, {
          query: query,
        })
        .then(res => (result = res.data))
        .catch(err => handleException(err, this.$route.path))
      this.endProcessing()

      return result
    },
    async executeQuery() {
      this.execResult = await this.execute(this.query)
      this.autoSlideToResultTab()
    },
    autoSlideToResultTab() {
      if (!this.preferences.autoSlide.enabled) return
      this.activeOutputTab = this.outputTabs.execResult.value
    },
    async handleTestQuery() {
      await this.executeQuery()
      this.testResult = this.testQuery()
      this.openTestResultModal()
    },
    testQuery() {
      const result = JSON.stringify(this.execResult.values)
      const resultModel = JSON.stringify(this.execResultModel.values)
      const status = result === resultModel ? 'success' : 'fail'
      return this.judgement[status]
    },
    moveInputTabTo(next = true) {
      const key = this.findTabKey(this.inputTabs, this.activeInputTab, next)
      this.activeInputTab = this.inputTabs[key].value
    },
    moveOutputTabTo(next = true) {
      const key = this.findTabKey(this.outputTabs, this.activeOutputTab, next)
      this.activeOutputTab = this.outputTabs[key].value
    },
    moveOutputTableTabTo(next = true) {
      switch (this.activeOutputTab) {
        case this.outputTabs.sampleDatabase.value:
          this.activeSampleTableTab = this.findTabIndex(this.sampleTables, this.activeSampleTableTab, next)
          break
        case this.outputTabs.execResult.value:
          this.activeExecResultTab = this.findTabIndex(this.execResult.values, this.activeExecResultTab, next)
          break
        default:
          break
      }
    },
    findTabKey(obj, key, next = true) {
      if (isEmpty(obj)) return

      const values = Object.values(obj)
      const maxIndex = values.length - 1
      let index = values.findIndex(value => value.value === key)

      next ? index++ : index--
      if (index < 0) index = maxIndex
      if (index > maxIndex) index = 0

      return Object.keys(obj)[index]
    },
    findTabIndex(arr, index, next = true) {
      if (isEmpty(arr)) return

      const maxIndex = arr.length - 1

      next ? index++ : index--
      if (index < 0) index = maxIndex
      if (index > maxIndex) index = 0

      return index
    },
    handleKeyboardEvent(e) {
      if (e.defaultPrevented) return
      if (!this.preferences.shortcut.enabled) return
      if (!e.ctrlKey && !e.metaKey) return

      const key = this.formatInputKeys(e)
      const event = this.findKeyBoardEvent(this.keyboardEvents, key)
      if (!event) return

      this.executeCommand(event.command, event.args || [])
    },
    formatInputKeys(e) {
      let keys = []

      if (e.ctrlKey) keys.push('ctrl')
      if (e.metaKey) keys.push('meta')
      keys.push(e.key)

      return keys.join('+')
    },
    findKeyBoardEvent(keyboardEvents, key) {
      return keyboardEvents.find(event => event.key === key)
    },
    executeCommand(command, args) {
      this[command](...args)
    },
    onMouseDown(e) {
      e.preventDefault()
      document.addEventListener('mousemove', this.onMouseMove)
      document.addEventListener('mouseup', this.onMouseUp)
    },
    onMouseMove(e) {
      e.preventDefault()

      let w = ((e.clientX - this.offsetX) / this.contentWidth) * 100
      if (w < 30) w = 30
      if (w > 70) w = 70

      this.resizableColumn = w + '%'
      this.notifyResize()
    },
    onMouseUp(e) {
      e.preventDefault()
      document.removeEventListener('mousemove', this.onMouseMove)
      document.removeEventListener('mouseup', this.onMouseUp)
    },
    notifyResize() {
      this.$refs.inputTabs.onResize()
      this.$refs.outputTabs.onResize()
    },
    calcContentWidth() {
      const content = getComputedStyle(this.$el.querySelector('.practice-content'))
      this.contentWidth = parseInt(content.width) - parseInt(content.padding) * 2
    },
    calcOffsetX() {
      const content = getComputedStyle(this.$el.querySelector('.practice-content'))
      const resizer = getComputedStyle(this.$el.querySelector('.practice-resizer'))
      this.offsetX = parseInt(content.paddingLeft) + parseInt(resizer.width) / 2
    },
    focusEditor() {
      this.$refs[this.camelCase(this.inputTabs.editor.value)].focus()
    },
    resetEditor() {
      this.$refs[this.camelCase(this.inputTabs.editor.value)].resetValue()
      this.focusEditor()
    },
    saveQuery() {
      const key = `${this.$route.params.slug}_${this.$route.params.id}`
      localStorage.setItem(key, this.query)
    },
    loadQuery() {
      const key = `${this.$route.params.slug}_${this.$route.params.id}`
      this.query = localStorage.getItem(key)
      this.$refs[this.camelCase(this.inputTabs.editor.value)].setValue()
    },
    savePreferences() {
      let obj = {}
      Object.keys(this.preferences).forEach(key => (obj[key] = this.preferences[key].enabled))
      localStorage.setItem('preferences', JSON.stringify(obj))
    },
    loadPreferences() {
      const preferences = JSON.parse(localStorage.getItem('preferences'))
      if (!preferences) return

      Object.keys(preferences).forEach(key => (this.preferences[key].enabled = preferences[key]))
    },
    updateQuery(query) {
      this.query = query
    },
    openErDiagramInNewTab() {
      if (!this.practice.displayErDiagram) return
      window.open(this.sampleDatabase.erDiagram)
    },
    openTestResultModal() {
      this.isTestResultModalActive = true
    },
    openExampleAnswerModal() {
      this.isExampleAnswerModalActive = true
    },
    openPreferenceListModal() {
      this.isPreferenceListModalActive = true
    },
    openShortcutListModal() {
      this.isShortcutListModalActive = true
    },
    startProcessing() {
      this.queryProcessing = true
    },
    endProcessing() {
      this.queryProcessing = false
    },
    togglePreference(key) {
      this.preferences[key].enabled = !this.preferences[key].enabled
    },
    setErDiagramMenuActivator() {
      const el = document.querySelector(`a[href="#${this.outputTabs.erDiagram.value}"]`)
      this.erDiagramMenu = el
    },
    moveNextPractice() {
      const nextId = this.findNextPracticeId()
      if (!nextId) {
        this.$router.push({
          name: 'Work',
          params: {
            slug: this.$route.params.slug,
          },
        })
      } else {
        this.$router.push({
          name: 'Practice',
          params: {
            slug: this.$route.params.slug,
            id: nextId,
          },
        })
      }
    },
    findNextPracticeId() {
      let practiceIds = []
      this.work.chapters.forEach(chapter => chapter.practices.forEach(practice => practiceIds.push(practice.id)))
      let i = practiceIds.findIndex(id => id === this.practice.id)

      return practiceIds[i + 1]
    },
  },
}
</script>

<style lang="scss" scoped>
.practice-content {
  display: grid;
  grid-template-rows: auto 1fr;
  grid-template-columns: 1fr 12px 1fr;
  grid-template-areas:
    'question question question'
    'tabs-left resizer tabs-right';
  height: calc(100vh - 56px);
  width: 100%;
  padding: 12px;
  row-gap: 12px;
  background: var(--bg-color);
}
.practice-footer {
  height: 56px;
  width: 100%;
  box-shadow: 0px 0px 6px -2px var(--shadow-color) !important;
}
.practice-question-wrap {
  grid-area: question;
}
.practice-tabs-wrap--left {
  grid-area: tabs-left;
}
.practice-resizer-wrap {
  grid-area: resizer;
  background: inherit;
}
.practice-tabs-wrap--right {
  grid-area: tabs-right;
}
.practice-tab {
  line-height: 1.5;
}
</style>
