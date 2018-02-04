<template>
<v-dialog
  v-model="$bus.dialog.addUser.model"
  fullscreen
  transition="dialog-bottom-transition"
  :overlay="false"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn icon @click.native="$bus.dialog.addUser.model = false" dark>
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Add User</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <v-text-field
          label="First name"
          v-model="fname"
          required/>
        <v-text-field
          label="Middle name"
          v-model="mname"/>
        <v-text-field
          label="Last name"
          v-model="lname"
          required/>
        <v-text-field
          label="Username"
          v-model="username"
          required/>
        <v-text-field
          label="Password"
          v-model="password"
          :type="hidePass.password ? 'password' : 'text'"
          :append-icon="hidePass.password ? 'visibility' : 'visibility_off'"
          :append-icon-cb="() => (hidePass.password = !hidePass.password)"
          required/>
        <v-text-field
          label="Confirm Password"
          v-model="passconf"
          :type="hidePass.passconf ? 'password' : 'text'"
          :append-icon="hidePass.passconf ? 'visibility' : 'visibility_off'"
          :append-icon-cb="() => (hidePass.passconf = !hidePass.passconf)"
          required/>
        <v-select
          :items="types"
          v-model="type"
          label="Select"
          single-line
          return-object
          bottom/>
        <v-switch
          :label="'Status: ' + (status ? 'Activated' : 'Deactivated')"
          v-model="status"/>
        <v-btn
          color="primary"
          @click="submit">Add</v-btn>
        <v-btn
          @click="clear">Clear</v-btn>
      </v-form>

    </v-card-text>

    <!-- end of content -->

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'

export default {
  name: 'add-user',
  data: () => ({
    url: '/users/add',
    formValid: false,
    fname: null,
    mname: null,
    lname: null,
    username: null,
    password: null,
    passconf: null,
    type: null,
    status: true,
    hidePass: {
      password: true,
      passconf: true
    },
    types: [
      { text: 'Admin', value: 1 },
      { text: 'Faculty', value: 2 }
    ]
  }),

  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.$http.post(this.url, qs.stringify({
          fname: this.fname,
          mname: this.mname,
          lname: this.lname,
          username: this.username,
          password: this.password,
          type: this.type.value,
          status: this.status ? 1 : 0
        })).then((res) => {
          if (!res.data.success) {
            throw new Error
          }
          this.$bus.dialog.addUser.model = false
          this.$bus.$emit('show-snackbar', 'Added user successfully.')
          this.$bus.$emit('update-manage-users')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('show-snackbar', 'Cannot add user.')
        })
      }
    },
    clear() {
      this.$refs.form.reset()
      this.fname = null
      this.mname = null
      this.lname = null
      this.username = null
      this.password = null
      this.passconf = null
      this.type = null
      this.hidePass.password = true
      this.hidePass.passconf = true
    }
  }
}
</script>
