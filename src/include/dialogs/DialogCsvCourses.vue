<template>
<v-dialog
  v-model="$bus.dialog.csvCourses.model"
  fullscreen
  transition="dialog-bottom-transition"
  :overlay="false"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn icon @click.native="$bus.dialog.csvCourses.model = false" dark>
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Upload Courses</v-toolbar-title>
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
  name: 'dialog-csv-courses',
  data: () => ({
    url: '/courses/addCsv',
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
        header: true,
        dynamicTyping: true,
        complete: (result) => {
          console.log(result)
          let courses = result.data.reduce((filtered, e) => {
            if (e.title && e.code) {
              filtered.push(e)
            }
            return filtered
          }, [])
          console.log(courses)

          // post
          this.$http.post(this.url, qs.stringify({
            courses: courses
          })).then((res) => {
            console.log(res.data)
            if (typeof res.data.success !== 'number') {
              throw new Error
            }
            this.$bus.progress.active = false
            this.$bus.dialog.csvCourses.model = false
            this.$bus.$emit('show-snackbar', 'Added courses successfully.')
            this.$bus.$emit('update-manage-courses')
            this.clear()
          }).catch((e) => {
            console.error(e)
            this.$bus.progress.active = false
            this.$bus.$emit('show-snackbar', 'Cannot add courses.')
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
