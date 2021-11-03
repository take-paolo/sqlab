module.exports = {
  moduleFileExtensions: [
    "js",
    "json",
    "vue"
  ],
  transform: {
    ".*\\.(vue)$": "vue-jest",
    "^.+\\.js$": "<rootDir>/node_modules/babel-jest"
  },
  transformIgnorePatterns: [
    "node_modules/"
  ],
  moduleNameMapper: {
    "^@/(.*)$": "<rootDir>/app/javascript/$1"
  },
  testMatch: [
    "**/tests/unit/**/*.spec.(js|jsx|ts|tsx)", "**/__tests__/**/*.(js|jsx|ts|tsx)"
  ],
  testEnvironment: "jsdom"
}
