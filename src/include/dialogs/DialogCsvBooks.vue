<template>
<v-dialog
  v-model="$bus.dialog.csvBook.model"
  fullscreen
  transition="dialog-bottom-transition"
  :overlay="false"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn icon @click.native="$bus.dialog.csvBook.model = false" dark>
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Upload Books</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <input type="file" required @change="onFileChange">
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
import Papa from 'papaparse'

export default {
  name: 'dialog-csv-books',
  data: () => ({
    url: 'books/addCsv',
    file: null,
    formValid: false
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
        // worker: true,
        dynamicTyping: true,
        complete: (result) => {
          console.log(result)
          let books = result.data.reduce((filtered, e) => {
            if (e[0].length && typeof e[1] === 'number') {
              filtered.push({
                citation: e[0],
                status: e[1]
              })
            }
            return filtered
          }, [])
          console.log(books)

          // post
          this.$http.post(this.url, qs.stringify({
            books: books
          })).then((res) => {
            console.log(res.data)
            if (typeof res.data.success !== 'number') {
              throw new Error
            }
            this.$bus.progress.active = false
            this.$bus.dialog.csvBook.model = false
            this.$bus.$emit('show-snackbar', 'Added books successfully.')
            this.$bus.$emit('update-manage-books')
            this.clear()
          }).catch((e) => {
            console.error(e)
            this.$bus.progress.active = false
            this.$bus.$emit('show-snackbar', 'Cannot add books.')
          })
        }
      })

    },
    clear() {
      this.$refs.form.reset()
      this.citation = null
      this.status = true
    }
  }
}
</script>
