<template>
<div>
  <form @submit.prevent="submit">
    <div>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="username">
    </div>

    <div>
      <label for="password">Password</label>
      <input type="password" id="password" v-model="password">
    </div>

    <div>
      <button type="submit">Login</button>
    </div>

    <template v-if="errorMsg">
      <br>
      <div>{{ errorMsg }}</div>
    </template>
  </form>
</div>
</template>

<script>
import qs from 'qs'
import storage from '@/assets/js/storage'

export default {
  name: 'login',
  data: () => ({
    loginUrl: '/login',
    username: '',
    password: '',
    errorMsg: ''
  }),

  created() {
    this.$emit('update-nav')
  },

  methods: {
    submit() {
      // handle login
      this.$http.post(this.loginUrl, qs.stringify({
        username: this.username,
        password: this.password
      })).then(res => {
        if (!res.data.success) {
          this.errorMsg = res.data.msg
          return
        }
        // save credentials here
        storage.set({ loggedOut: false })
        this.$router.push('/dashboard')
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
