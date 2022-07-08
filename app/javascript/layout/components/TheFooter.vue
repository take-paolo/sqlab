<template>
  <div>お問い合わせ twitter 利用規約 プライバシーポリシー</div>
</template>

<script>
export default {
  name: 'TheFooter',
  components: {},
  data() {
    return {
      navs: [
        {
          header: '一般',
          list: [
            {
              title: 'トップページ',
              icon: 'mdi-home',
              to: {
                name: 'Top',
              },
              disabled: false,
            },
            {
              title: 'カリキュラム一覧',
              icon: 'mdi-database',
              to: {
                name: 'Curriculums',
              },
              disabled: false,
            },
            {
              title: 'ヘルプ',
              icon: 'mdi-help-circle-outline',
              to: '',
              disabled: true,
            },
            {
              title: '学習ロードマップ',
              icon: 'mdi-chart-timeline-variant',
              to: '',
              disabled: true,
            },
            {
              title: 'お問い合わせ',
              icon: 'mdi-email-outline',
              to: '',
              disabled: true,
            },
          ],
        },
        {
          header: 'アカウント',
          list: [
            {
              title: 'マイページ',
              icon: 'mdi-account',
              to: '',
              disabled: true,
            },
            {
              title: 'ログイン',
              icon: 'mdi-login-variant',
              to: '',
              disabled: true,
            },
          ],
        },
        {
          header: 'SNS',
          list: [
            {
              title: 'Twitter',
              icon: 'mdi-twitter',
              to: '',
              disabled: true,
            },
          ],
        },
        {
          header: 'その他',
          list: [
            {
              title: '利用規約',
              icon: 'mdi-file-document-outline',
              to: '',
              disabled: true,
            },
            {
              title: 'プライバシーポリシー',
              icon: 'mdi-shield-account',
              to: '',
              disabled: true,
            },
          ],
        },
      ],
    }
  },
  computed: {},
  mounted() {},
  updated() {},
  methods: {},
}
</script>
