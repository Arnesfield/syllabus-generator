export default {
  model: false,
  inst: {
    ManageUsers: {
      color: 'accent',
      before: 'add',
      after: 'close',
      btns: [
        { icon: 'person_add', tip: 'Add User', cb: 'manage--users.add' },
        { icon: 'file_upload', tip: 'Upload CSV file', cb: 'manage--users.upload' }
      ]
    },
    ManageCourses: {
      color: 'accent',
      before: 'add',
      after: 'close',
      btns: [
        { icon: 'school', tip: 'Add Course', cb: 'manage--courses.add' },
        { icon: 'file_upload', tip: 'Upload CSV file', cb: 'manage--courses.upload' }
      ]
    },
    ManageBooks: {
      color: 'accent',
      before: 'add',
      after: 'close',
      btns: [
        { icon: 'book', tip: 'Add Book', cb: 'manage--books.add' },
        { icon: 'file_upload', tip: 'Upload CSV file', cb: 'manage--books.upload' }
      ]
    },
    ManageCurriculum: {
      color: 'accent',
      before: 'add',
      after: 'close',
      click: 'curriculum--add',
      tip: 'Add curriculum',
      btns: null
    },
    ManageOutcomes: {
      color: 'accent',
      before: 'add',
      after: 'close',
      click: 'outcome--add',
      tip: 'Add Outcome',
      btns: null
    },
    Workflow: {
      color: 'accent',
      before: 'add',
      after: 'close',
      click: 'workflow--add',
      tip: 'Create workflow',
      btns: null
    }
  }
}
