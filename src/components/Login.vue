<template>
<v-content>
  <v-container fluid>
    <form @submit.prevent="submit">
      <div>
        <v-text-field
          id="username"
          label="Username"
          v-model="username"/>
      </div>

      <div>
        <v-text-field
          id="password"
          label="Password"
          v-model="password"
          :append-icon="passwordHide ? 'visibility' : 'visibility_off'"
          :append-icon-cb="() => (passwordHide = !passwordHide)"
          :type="passwordHide ? 'password' : 'text'"/>
      </div>

      <div>
        <v-btn color="primary" type="submit">Login</v-btn>
      </div>

      <template v-if="errorMsg.length">
        <br>
        <div>{{ errorMsg }}</div>
      </template>
    </form>
  </v-container>
</v-content>
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
    errorMsg: '',
    passwordHide: true
  }),

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
        let user = res.data.user
        // save credentials here
        storage.set({
          isSet: true,
          user: {
            fname: user.fname,
            mname: user.mname,
            lname: user.lname,
            username: user.username,
            imgSrc: user.imgSrc
          }
        })
        this.$router.push('/dashboard')
        this.$bus.$emit('show-snackbar', 'Logged in successfully.', null)
      }).catch(e => {
        console.error(e)
      })
    }
  }
}
</script>
