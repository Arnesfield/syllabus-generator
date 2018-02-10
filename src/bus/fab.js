export default {
  model: false,
  inst: {
    '/manage/users': {
      color: 'accent',
      before: 'add',
      after: 'close',
      click: 'fab--user.add',
      tip: 'Add User',
      btns: null
    }
  }
}
