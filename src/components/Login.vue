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
export default {
  name: 'login',
  data: () => ({
    username: '',
    password: ''
  }),

  methods: {
    submit() {
      // handle login
    }
  }
}
</script>
