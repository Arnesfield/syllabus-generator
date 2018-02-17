<template>
<v-dialog
  v-model="$bus.dialog.ManageUsers.csv"
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
        @click.native="$bus.dialog.ManageUsers.csv = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Upload Users</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <input type="file" required @change="onFileChange">
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
      >Upload</v-btn>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import Papa from 'papaparse'

export default {
  name: 'dialog-csv-users',
  data: () => ({
    url: '/users/addCsv',
    file: null,
    formValid: false,
    loading: false
  }),

  methods: {
    onFileChange(e) {
      if (typeof e.target.files[0] === 'undefined') {
        this.file = null
        return
      }
      this.file = e.target.files[0]
      console.log(this.file)
    },

    submit() {
      if (this.file === null) {
        return
      }

      if (!this.$refs.form.validate()) {
        return
      }

      this.$bus.progress.active = true
      Papa.parse(this.file, {
        header: true,
        dynamicTyping: true,
        complete: (result) => {
          console.log(result)
          let users = result.data.reduce((filtered, e) => {
            if (e.username && e.password) {
              filtered.push(e)
            }
            return filtered
          }, [])
          console.log(users)

          // post
          this.$http.post(this.url, qs.stringify({
            users: users
          })).then((res) => {
            console.log(res.data)
            if (typeof res.data.success !== 'number') {
              throw new Error
            }
            this.$bus.progress.active = false
            this.$bus.dialog.ManageUsers.csv = false
            this.$bus.$emit('snackbar--show', 'Added users successfully.')
            this.$bus.$emit('manage--users.update')
            this.clear()
          }).catch((e) => {
            console.error(e)
            this.$bus.progress.active = false
            this.$bus.$emit('snackbar--show', 'Cannot add users.')
          })
        }
      })

    },
    clear() {
      this.$refs.form.reset()
    }
  }
}
</script>
