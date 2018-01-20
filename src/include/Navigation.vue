<template>
<v-navigation-drawer
  app
  fixed
  v-model="bus.drawer">
  <v-toolbar flat prominent extended>
    <v-toolbar-title>
      <v-avatar class="primary">
        <template v-if="imgSrc">
          <img v-if="imgSrc.isImg" :src="imgSrc.text" alt="avatar">
          <span v-else class="white--text headline">{{ imgSrc.text }}</span>
        </template>
        <template v-else>
          <span class="white--text headline">?</span>
        </template>
      </v-avatar>
    </v-toolbar-title>
    <v-list slot="extension">
      <v-list-tile>
        <v-list-tile-content>
          <v-list-tile-title class="title">{{ fullname }}</v-list-tile-title>
          <v-list-tile-sub-title>{{ username }}</v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-toolbar>
  <v-list dense>
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

  computed: {
    // toolbar data
    fullname() {
      let user = storage.get('user')
      if (typeof user !== 'object') {
        return ''
      }
      return user.fname + ' ' + user.lname
    },
    username() {
      let user = storage.get('user')
      if (typeof user !== 'object') {
        return ''
      }
      return user.username
    },
    imgSrc() {
      let user = storage.get('user')
      if (typeof user !== 'object') {
        return null
      }
      if (typeof user.imgSrc !== 'string') {
        return {
          isImg: false,
          text: user.fname.charAt(0).toUpperCase()
        }
      } 
      return {
        isImg: true,
        text: user.imgSrc
      }
    }
  },

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
