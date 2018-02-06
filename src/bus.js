import Vue from 'vue'

export default new Vue({
  data: () => ({
    // all
    user: null,
    // toolbar
    toolbar: {
      drawer: null,
      tab: null,
      tabs: null,
      tabItems: null,
      menu: null
    },
    progress: {
      active: false,
      indeterminate: true
    },
    // dialogs
    dialog: {
      addUser: {
        model: false
      },
      csvUsers: {
        model: false
      },
      addCourse: {
        model: false
      },
      csvCourses: {
        model: false
      },
      addBook: {
        model: false
      },
      csvBooks: {
        model: false
      }
    },
    // generator
    generator: {
      suggestions: true,
      warn: true
    },
    // fab
    fab: {
      model: false,
      manageUsers: {
        color: 'accent',
        before: 'add',
        after: 'close',
        btns: [
          { icon: 'person_add', tip: 'Add User', cb: 'fab-manage-users-user-add' },
          { icon: 'file_upload', tip: 'Upload CSV file', cb: 'fab-manage-users-file-upload' }
        ]
      },
      manageCourses: {
        color: 'accent',
        before: 'add',
        after: 'close',
        btns: [
          { icon: 'school', tip: 'Add Course', cb: 'fab-manage-courses-course-add' },
          { icon: 'file_upload', tip: 'Upload CSV file', cb: 'fab-manage-courses-file-upload' }
        ]
      },
      manageBooks: {
        color: 'accent',
        before: 'add',
        after: 'close',
        btns: [
          { icon: 'book', tip: 'Add Book', cb: 'fab-manage-books-book-add' },
          { icon: 'file_upload', tip: 'Upload CSV file', cb: 'fab-manage-books-file-upload' }
        ]
      }
    }
  }),

  watch: {
    'generator.suggestions': function(to, from) {
      if (to == false && this.generator.warn == false) {
        this.generator.warn = true
      }
      this.$emit('bus-generator-suggestion-change')
    }
  },

  methods: {
    fabProp(path) {
      switch (path) {
        case '/manage/users':
          return this.fab.manageUsers
        case '/manage/courses':
          return this.fab.manageCourses
        case '/manage/books':
          return this.fab.manageBooks
      }
      return null
    }
  }
})
