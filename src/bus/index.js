import Vue from 'vue'
import session from './session'
import progress from './progress'
import settings from './settings'

export default new Vue({
  data: () => ({
    session: session,
    progress: progress,
    settings: settings
  }),

  watch: {
    'session.auth': function(to, from) {
      this.$emit('GET_ROUTE', 'watch--session.auth')
    }
  },

  computed: {
    componentWithAuth() {
      return this.session.auth >= 3
    }
  },

  methods: {
    sessionCheck(route, http) {
      http.post('/sess').then((res) => {
        this.sessionSet(res.data)
        // watch--session.auth is called when session.auth is changed
      }).catch(e => {
        console.error(e)
      })
    },
    sessionSet(data) {
      const sessionFields = [
        { key: 'user', def: null },
        { key: 'auth', def: 0 }
      ]
      sessionFields.forEach(e => {
        // set default value if data does not exist
        this.session[e.key] = data[e.key] || e.def
      })
      // set settings if user exists and if settings exists
      if (!data.user || !data.user.settings) {
        return
      }

      const settingsFields = [
        { key: 'dark', def: false }
      ]

      let settings = JSON.parse(data.user.settings)
      settingsFields.forEach(e => {
        this.settings[e] = settings[e] ? settings[e] : e.def
      })
    }
  }
})
