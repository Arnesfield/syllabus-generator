<template>
<v-navigation-drawer
  app
  fixed
  width="272"
  v-model="$bus.drawer">
  <div class="bg" style="background-image: url('./static/images/bg-2.sm.jpg')">
    <v-container fluid class="no-bg dim">
      <v-avatar class="primary elevation-6">
        <template v-if="imgSrc">
          <img v-if="imgSrc.isImg" :src="imgSrc.text" alt="avatar">
          <span v-else class="white--text headline">{{ imgSrc.text }}</span>
        </template>
        <template v-else>
          <span class="white--text headline">?</span>
        </template>
      </v-avatar>
    </v-container>
    <v-list class="no-bg dim">
      <v-list-tile>
        <v-list-tile-content>
          <v-list-tile-title class="title white--text">{{ fullname }}</v-list-tile-title>
          <v-list-tile-sub-title class="grey--text text--lighten-3">{{ username }}</v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </div>
  <v-list dense>
    <v-list-tile
      ripple
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

    <v-list-tile ripple v-if="isLoggedIn" @click="logout">
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
        storage.destroy()
        storage.set({ loggedOut: true })
        this.updateNav()
        this.$router.push('/')
        // hide drawer
        this.$bus.drawer = null
        this.$bus.$emit('show-snackbar', 'Logged out successfully.', null)
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
