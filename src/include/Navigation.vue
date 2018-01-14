<template>
<v-navigation-drawer fixed app v-model="bus.drawer">
  <v-list>
    <v-list-tile
      :key="i"
      v-for="(nav, i) in navList"
      v-if="nav.logged == isLoggedIn"
      @click="$router.push(nav.to)">
      <v-list-tile-action>
        <v-icon>{{ nav.icon }}</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title>{{ nav.title }}</v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>

    <v-list-tile v-if="isLoggedIn" @click="logout">
      <v-list-tile-action>
        <v-icon>exit_to_app</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title>Logout</v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>
  </v-list>
</v-navigation-drawer>
</template>

<script>
import storage from '@/assets/js/storage'

export default {
  name: 'navigation',
  props: {
    bus: {
      type: Object,
      required: true
    }
  },
  data: () => ({
    logoutUrl: '/logout',
    isLoggedIn: false,
    navList: [
      { title: 'Home', icon: 'home', to: '/', logged: false },
      { title: 'Login', icon: 'exit_to_app', to: '/login', logged: false },
      { title: 'Home', icon: 'dashboard', to: '/dashboard', logged: true },
      { title: 'Syllabi', icon: 'find_in_page', to: '/syllabi', logged: true },
      { title: 'Generator', icon: 'build', to: '/generator', logged: true }
    ]
  }),

  methods: {
    updateNav() {
      this.isLoggedIn = typeof storage.get('isSet') !== 'undefined'
    },
    logout() {
      this.$http.post(this.logoutUrl).then(res => {
        if (!res.data.success) {
          throw new Error
        }
        alert('Logged out successfully.')
        storage.destroy()
        storage.set({ loggedOut: true })
        this.updateNav()
        this.$router.push('/')
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
