<template>
<div>
  <nav>
    <ul>
      <li :key="index" v-for="(nav, index) in navList" v-if="nav.logged == isLoggedIn">
        <router-link :to="nav.to">{{ nav.title }}</router-link>
      </li>
      <li v-if="isLoggedIn">
        <a @click="logout">Logout</a>
      </li>
    </ul>
  </nav>
</div>
</template>

<script>
import storage from '@/assets/js/storage'

export default {
  name: 'navigation',
  data: () => ({
    logoutUrl: '/logout',
    isLoggedIn: false,
    navList: [
      { title: 'Home', to: '/', logged: false },
      { title: 'Login', to: '/login', logged: false },
      { title: 'Home', to: '/dashboard', logged: true },
      { title: 'Syllabi', to: '/syllabi', logged: true },
      { title: 'Generator', to: '/generator', logged: true }
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
