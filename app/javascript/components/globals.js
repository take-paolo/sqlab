import Vue from 'vue'

const modules = import.meta.glob(['./**/(Base|App)[A-Z]*.vue', './**/(Base|App)[A-Z]*.js'], { eager: true })

// For each matching file...
Object.entries(modules).forEach(([path, module]) => {
  // Get the component name from the file path
  const componentName = path.replace(/^.+\//, '').replace(/\.\w+$/, '')

  // Globally register the component
  Vue.component(componentName, module.default || module)
})
