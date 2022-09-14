// codemirror
import CodeMirror from 'codemirror'
import 'codemirror/lib/codemirror.css'
// theme
import 'codemirror/theme/mbo.css'
// mode
import 'codemirror/mode/sql/sql.js'
// addon
import 'codemirror/addon/comment/comment.js'
import 'codemirror/addon/display/autorefresh.js'
import 'codemirror/addon/selection/active-line.js'

const mime = 'text/x-pgsql'
const sqlKeywords =
  'abs all alter and any as asc avg between by case cast ceil ceiling count create delete desc distinct div drop except exists floor from full group having in inner insert intersect into is join left length like limit max min not on or order outer power replace right round select set some substring sum table temporary trim trunc union update values where'
const removalKeyMaps = 'Ctrl-K Ctrl-O Ctrl-R'

// set keywords to MIME specified in arguments
function setKeywords(mime, keywords) {
  let mode = CodeMirror.mimeModes[mime]
  mode.keywords = format(keywords)
}

// turn a space-separated list into an array
function format(str) {
  let obj = {}
  const words = str.split(' ')
  for (let i = 0; i < words.length; ++i) obj[words[i]] = true
  return obj
}

setKeywords(mime, sqlKeywords)

export function createEditor(id, readOnly = false) {
  return CodeMirror.fromTextArea(document.getElementById(id), {
    autofocus: true,
    autoRefresh: true,
    lineNumbers: true,
    lineSeparator: '\n',
    mode: mime,
    readOnly: readOnly,
    styleActiveLine: true,
    theme: 'mbo',
    extraKeys: {
      'Cmd-/': 'toggleComment',
    },
  })
}

export function removeKeyMaps(editor) {
  let obj = {}
  const words = removalKeyMaps.split(' ')
  for (let i = 0; i < words.length; ++i) obj[words[i]] = false
  editor.addKeyMap(obj)
}
