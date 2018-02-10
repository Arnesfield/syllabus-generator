<template>
<v-navigation-drawer
  app
  fixed
  :mini-variant="$bus.nav.miniVariant"
  :clipped="$bus.nav.clipped"
  v-model="$bus.nav.model"
  tabindex="1"
>
  <nav-user/>
  <v-list
    class="pb-0"
    :class="{ 'py-0': i != 0 }"
    :key="i"
    v-if="list.auth >= $bus.session.auth"
    v-for="(list, i) in lists"
    :subheader="Boolean(list.header)"
  >
    <v-subheader
      class="grey--text"
      v-if="list.header"
    >{{ list.header }}</v-subheader>
    <template v-for="(item, i) in list.items">
      <v-divider :key="i" v-if="typeof item !== 'object'"/>
      <v-tooltip
        :key="i"
        v-else
        :disabled="!$bus.nav.miniVariant"
        right
      >
        <v-list-tile
          ripple
          slot="activator"
          :to="item.to"
          @keypress.enter="listItemClick(item.click)"
          @click="listItemClick(item.click)"
          :exact-active-class="item.to"
          tabindex="1"
        >
          <v-list-tile-action>
            <v-icon v-html="item.icon"></v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title v-text="item.title"></v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <span>{{ item.title }}</span>
      </v-tooltip>
    </template>
  </v-list>

  <v-footer fixed :height="null" style="background-color: inherit">
    <v-list class="full-width">
      <v-tooltip right :disabled="!$bus.nav.miniVariant">
        <v-list-tile
          ripple
          tabindex="1"
          slot="activator"
          @click="$bus.nav.miniVariant = !$bus.nav.miniVariant">
          <v-list-tile-action>
            <v-btn
              icon
              tabindex="1"
              :ripple="false"
              @click.stop="$bus.nav.miniVariant = !$bus.nav.miniVariant">
              <v-icon v-html="$bus.nav.miniVariant ? 'chevron_right' : 'chevron_left'"/>
            </v-btn>
          </v-list-tile-action>
          <v-list-tile-content>{{ collapseText }}</v-list-tile-content>
        </v-list-tile>
        <span>{{ collapseText }}</span>
      </v-tooltip>
    </v-list>
  </v-footer>
</v-navigation-drawer>
</template>

<script>
import NavUser from './nav/NavUser'

export default {
  name: 'navigation',
  components: {
    NavUser
  },
  data: () => ({
    logoutUrl: '/logout',
    lists: [
      {
        header: '',
        auth: 3,
        items: [
          { title: 'Dashboard', icon: 'dashboard', to: '/dashboard' }
        ]
      },
      {
        header: 'Manage',
        auth: 2,
        items: [
          { title: 'Users', icon: 'account_circle', to: '/manage/users' },
        ]
      },
      // logout
      {
        auth: 10,
        items: [
          '',
          { title: 'Logout', icon: 'exit_to_app', click: 'logout' }
        ]
      }
    ]
  }),

  computed: {
    collapseText() {
      return this.$bus.nav.miniVariant ? 'Expand' : 'Collapse'
    }
  },

  methods: {
    logout() {
      // logout here
      this.$http.post(this.logoutUrl).then((res) => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.$bus.sessionCheck(this.$route, this.$http)
      }).catch(e => {
        console.error(e)
      })
    },

    listItemClick(e) {
      if (typeof e === 'string') {
        this[e]()
      }
    }
  }
}
</script>
