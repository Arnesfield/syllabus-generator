<template>
<v-dialog
  v-model="$bus.dialog.addCourse.model"
  fullscreen
  transition="dialog-bottom-transition"
  :overlay="false"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn icon @click.native="$bus.dialog.addCourse.model = false" dark>
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Add Course</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <v-text-field
          label="Title"
          v-model="title"
          required/>
        <v-text-field
          label="Code"
          v-model="code"
          required/>
        <v-text-field
          label="Units Lecture"
          v-model="unitsLec"
          required/>
        <v-text-field
          label="Units Laboratory"
          v-model="unitsLab"
          required/>
        <v-text-field
          label="Description"
          v-model="description"
          multi-line
          required/>
        <v-text-field
          label="Objectives"
          v-model="objectives"
          multi-line
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
  name: 'dialog-add-course',
  data: () => ({
    url: '/courses/add',
    formValid: false,
    title: null,
    code: null,
    description: null,
    objectives: null,
    unitsLec: null,
    unitsLab: null,
    status: true
  }),

  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.$http.post(this.url, qs.stringify({
          title: this.title,
          code: this.code,
          description: this.description,
          objectives: this.objectives,
          unitsLec: this.unitsLec,
          unitsLab: this.unitsLab,
          status: this.status ? 1 : 0
        })).then((res) => {
          if (!res.data.success) {
            throw new Error
          }
          this.$bus.dialog.addCourse.model = false
          this.$bus.$emit('show-snackbar', 'Added course successfully.')
          this.$bus.$emit('update-manage-courses')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('show-snackbar', 'Cannot add course.')
        })
      }
    },
    clear() {
      this.$refs.form.reset()
      this.title = null
      this.code = null
      this.description = null
      this.objectives = null
      this.unitsLec = null
      this.unitsLab = null
      this.status = true
    }
  }
}
</script>
