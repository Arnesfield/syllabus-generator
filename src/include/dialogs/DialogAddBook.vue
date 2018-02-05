<template>
<v-dialog
  v-model="$bus.dialog.addBook.model"
  fullscreen
  transition="dialog-bottom-transition"
  :overlay="false"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn icon @click.native="$bus.dialog.addBook.model = false" dark>
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Add Book</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <v-text-field
          label="Citation"
          v-model="citation"
          required/>
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
  name: 'dialog-add-book',
  data: () => ({
    url: '/books/add',
    formValid: false,
    citation: null,
    status: true
  }),

  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.$http.post(this.url, qs.stringify({
          citation: this.citation,
          status: this.status ? 1 : 0
        })).then((res) => {
          if (!res.data.success) {
            throw new Error
          }
          this.$bus.dialog.addBook.model = false
          this.$bus.$emit('show-snackbar', 'Added book successfully.')
          this.$bus.$emit('update-manage-books')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('show-snackbar', 'Cannot add book.')
        })
      }
    },
    clear() {
      this.$refs.form.reset()
      this.citation = null
      this.status = true
    }
  }
}
</script>
