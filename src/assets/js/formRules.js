const msgs = {
  required: 'This field is required.',
  email: 'Invalid email.',
  chars: 'Requires more characters.',
  match: 'Value does not match.',
  nonExisting: 'This already exists.',
  duplicateEmail: 'This email already exists.'
}

let rules = {
  required: (msg) => (e) => !!e || msg,
  email: (msg) => (e) => {
    const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    return pattern.test(e) || msg
  },
  chars: (msg, n) => (e) => (e ? e.length >= n : false) || msg,
  match: (msg, match) => (e) => e == match || msg,
  nonExisting: (msg, arr) => (e) => {
    if (!arr) { return true }
    return arr.indexOf(e) == -1 || msg
  },
  duplicateEmail: (msg, val) => (e) => {
    let cond = typeof val === 'boolean' ? !val : false
    return cond ? true : msg
  }
}

export default function(rule, msg, param) {
  msg = msg ? msg : msgs[rule]
  return rules[rule](msg, param)
}
