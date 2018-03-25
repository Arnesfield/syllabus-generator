import Vue from 'vue'
import fab from './fab'
import nav from './nav'
import dialog from './dialog'
import session from './session'
import progress from './progress'
import toolbar from './toolbar'
import tabs from './tabs'
import generator from './generator'
import settings from './settings'
import toNumberArray from '@/assets/js/toNumberArray'

export default new Vue({
  data: () => ({
    fab: fab,
    nav: nav,
    dialog: dialog,
    session: session,
    progress: progress,
    toolbar: toolbar,
    tabs: tabs,
    generator: generator,
    settings: settings
  }),

  watch: {
    'session.auth': function(to, from) {
      this.$emit('GET_ROUTE', 'watch--session.auth')
    },
    'dialog.global.confirm': function(to, from) {
      this.$emit('watch--dialog.global.confirm', to, from)
    },
    'generator.suggestions': function(to, from) {
      if (to == false && this.generator.warn == false) {
        this.generator.warn = true
      }
      this.$emit('watch--generator.suggestions')
    }
  },
  
  methods: {
    refresh(e) {
      this.progress.active = e
      this.progress.refresh = e
    },

    navToggle() {
      if (this.nav.model) {
        if (this.nav.miniVariant) {
          this.nav.model = false
        } else {
          this.nav.miniVariant = true
        }
      } else {
        this.nav.model = true
        this.nav.miniVariant = false
      }
    },

    authCheck(routeAuth) {
      // check if routeAuth in session auth
      return this.authHas(routeAuth, this.session.auth)
        && !this.authHas(routeAuth, [0, 10])
    },

    authHas(auth, n, concat) {
      // convert to array
      auth = toNumberArray(auth)
      // also convert n to array
      n = toNumberArray(n)
      
      // do concat
      if (typeof concat === 'object' || typeof concat === 'number') {
        n = toNumberArray(n.concat(concat))
      }
      // check if some n exists in auth
      let result = false
      auth.every(e => !(result = n.indexOf(e) > -1))
      return result
    },

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
        { key: 'dark', type: 'boolean', def: false }
      ]

      let settings = JSON.parse(data.user.settings)
      settingsFields.forEach(e => {
        this.settings[e] = typeof settings[e] === e.type ? settings[e] : e.def
      })
    }
  }
})
