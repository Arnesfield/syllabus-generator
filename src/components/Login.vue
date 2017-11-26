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
  </form>
</div>
</template>

<script>
const qs = require('qs')

export default {
  name: 'login',
  data: () => ({
    loginUrl: '/login',
    username: '',
    password: ''
  }),

  methods: {
    submit() {
      // handle login
      this.$http.post(this.loginUrl, qs.stringify({
        username: this.username,
        password: this.password
      })).then(res => {
        console.log(res.data)
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
