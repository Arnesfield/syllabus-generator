<template>
<v-dialog
  v-model="$bus.dialog.ManageUsers.add"
  width="800"
  :overlay="false"
  :persistent="loading"
  transition="fade-transition"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn
        icon
        dark
        :disabled="loading"
        @click.native="$bus.dialog.ManageUsers.add = false"
      >
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
      </v-form>

    </v-card-text>

    <!-- end of content -->

    <v-card-actions class="pa-4 bg-dim">
      <template v-if="loading">
        <v-progress-circular
          indeterminate
          :active="loading"
          color="primary"
        />
        <span style="height: auto" class="subheader px-2">Loading...</span>
      </template>
      <v-spacer/>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        @click="clear"
      >Clear</v-btn>
      <v-btn
        color="primary"
        tabindex="0"
        :disabled="loading"
        @click="submit"
      >{{ mode }}</v-btn>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'

export default {
  name: 'dialog-add-user',
  props: {
    mode: {
      type: String,
      default: 'Add'
    }
  },
  data: () => ({
    url: '/users/add',
    formValid: false,
    fname: null,
    mname: null,
    lname: null,
    username: null,
    password: null,
    passconf: null,
    img_src: null,
    type: null,
    status: true,
    hidePass: {
      password: true,
      passconf: true
    },
    types: [
      { text: 'Admin', value: 3 },
      { text: 'Faculty', value: 4 }
    ],
    
    loading: false
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
          img_src: '',
          type: this.type.value,
          status: this.status ? 1 : 0
        })).then((res) => {
          if (!res.data.success) {
            throw new Error
          }
          this.$bus.dialog.ManageUsers.add = false
          this.$bus.$emit('snackbar--show', 'Added user successfully.')
          this.$bus.$emit('manage--users.update')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('snackbar--show', 'Cannot add user.')
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
