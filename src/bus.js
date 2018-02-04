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
      active: false
    },
    // dialogs
    dialog: {
      addUser: {
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
          { icon: 'person_add', tip: 'Add User', cb: 'fab-manage-users-person-add' },
          { icon: 'file_upload', tip: 'Upload CSV file', cb: 'fab-manage-users-file-upload' }
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
      }
      return null
    }
  }
})
