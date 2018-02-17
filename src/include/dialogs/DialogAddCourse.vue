<template>
<v-dialog
  v-model="$bus.dialog.ManageCourses.add"
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
        @click.native="$bus.dialog.ManageCourses.add = false"
      >
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
  name: 'dialog-add-course',
  props: {
    mode: {
      type: String,
      default: 'Add'
    }
  },
  data: () => ({
    url: '/courses/add',
    formValid: false,
    title: null,
    code: null,
    description: null,
    objectives: null,
    unitsLec: null,
    unitsLab: null,
    status: true,
    loading: false
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
          this.$bus.dialog.ManageCourses.add = false
          this.$bus.$emit('snackbar--show', 'Added course successfully.')
          this.$bus.$emit('manage--courses.update')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('snackbar--show', 'Cannot add course.')
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
