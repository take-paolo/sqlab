import Vue from 'vue'

const requireComponent = require.context(
  // Look for files in the current directory
  '.',
  // look in subdirectories
  true,
  // Only include "Base" prefixed .vue or .js files
  /(Base|App)[A-Z]\w+\.(vue|js)$/
)

// For each matching file name...
requireComponent.keys().forEach(fileName => {
  // Get the component config
  const componentConfig = requireComponent(fileName)
  // Get the component name
  const componentName = fileName.replace(/^.+\//, '').replace(/\.\w+$/, '')

  // Globally register the component
  Vue.component(componentName, componentConfig.default || componentConfig)
})
