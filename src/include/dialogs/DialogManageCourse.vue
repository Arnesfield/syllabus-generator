<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="fade-transition"
  width="800"
  scrollable
>
  <v-card>

    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      background-color="primary lighten-1"
      class="ma-0 primary lighten-1"
    />

    <v-toolbar
      dark
      card
      color="primary lighten-1"
    >
      <v-btn
        icon
        dark
        :disabled="loading"
        @click="show = false"
        @keypress.enter="show = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title
        v-text="mode == 'add' ? 'Add Course' : 'Update Course'"
      />
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">
        
        <!-- title -->

        <v-layout align-baseline>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Title and Code</v-subheader>
          </v-flex>
          <v-flex sm8>
            <v-text-field
              label="Title"
              color="primary lighten-1"
              v-model="title"
              :disabled="loading"
              prepend-icon="title"
              :rules="[$fRule('required')]"
              required
            />
            <v-text-field
              label="Code"
              color="primary lighten-1"
              v-model="code"
              :disabled="loading"
              prepend-icon="code"
              :rules="[$fRule('required')]"
              required
            />
          </v-flex>
        </v-layout>

        <!-- name -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>
              <div>
                <div>No. of Units</div>
                <div class="caption" v-text="'lecture and laboratory'"/>
              </div>
            </v-subheader>
          </v-flex>
          <v-flex sm8>
            
            <v-layout>
              <v-flex xs12 sm6>
                <v-text-field
                  label="Lecture"
                  type="number"
                  prepend-icon="person"
                  v-model="unitsLec"
                  color="primary lighten-1"
                  :disabled="loading"
                  :rules="[$fRule('required'), $fRule('min', null, 0)]"
                  required
                />
              </v-flex>
              <v-flex xs12 sm6>
                <v-text-field
                  label="Laboratory"
                  type="number"
                  color="primary lighten-1"
                  class="ml-1"
                  v-model="unitsLab"
                  :disabled="loading"
                  :rules="[$fRule('required'), $fRule('min', null, 0)]"
                  required
                />
              </v-flex>
            </v-layout>

          </v-flex>
        </v-layout>

        <!-- description -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Description</v-subheader>
          </v-flex>
          <v-flex sm8>
            <markdown-textarea
              :md-view="false"
              v-model="description"
              placeholder="Enter course description"
              t-add-class="my-medium-textarea pa-2"
              ref="mdDescription"
              required
            />
          </v-flex>
        </v-layout>

        <!-- objectives -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Objectives</v-subheader>
          </v-flex>
          <v-flex sm8>
            <markdown-textarea
              :md-view="false"
              v-model="objectives"
              t-add-class="my-medium-textarea pa-2"
              placeholder="Enter course objectives"
            />
          </v-flex>
        </v-layout>

        <!-- prerequisites -->

        <v-layout align-baseline class="mt-1">
          <v-flex hidden-xs-only sm4>
            <v-subheader>Prerequisites</v-subheader>
          </v-flex>
          <v-flex sm8>
            <div
              v-if="prerequisites.length"
              class="caption grey--text text--darken-1"
            >Prerequisites</div>
            <select-courses
              :course-id="id"
              v-model="prerequisites"
              :disabled="loading"
              color="primary lighten-1"
              label="Search prerequisites"
              btn="Select prerequisite/s"
            />
          </v-flex>
        </v-layout>

        <!-- corequisites -->

        <v-layout align-baseline class="mt-1">
          <v-flex hidden-xs-only sm4>
            <v-subheader>Corequisites</v-subheader>
          </v-flex>
          <v-flex sm8>
            <div
              v-if="corequisites.length"
              class="caption grey--text text--darken-1"
            >Corequisites</div>
            <select-courses
              :course-id="id"
              v-model="corequisites"
              :disabled="loading"
              color="primary lighten-1"
              label="Search corequisites"
              btn="Select corequisite/s"
            />
          </v-flex>
        </v-layout>


        <!-- tags -->

        <v-layout align-content-start class="mt-2">
          <v-flex hidden-xs-only sm4>
            <v-subheader>Related tags</v-subheader>
          </v-flex>
          <v-flex sm8>
            <select-tags
              v-model="tags"
              :disabled="loading"
              color="primary lighten-1"
              placeholder="(e.g. programming, art, etc.)"
            />
          </v-flex>
        </v-layout>

        <!-- status -->

        <v-layout align-center>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Status</v-subheader>
          </v-flex>
          <v-flex sm8>
            <select-status
              v-model="status"
              :items="statusTypes"
              :loading="loading"
              required
            />
          </v-flex>
        </v-layout>

      </v-form>
    </v-card-text>

    <v-divider/>
    <v-card-actions>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        @click="show = false"
        @keypress.enter="show = false"
        v-text="'Cancel'"
      />
      <v-spacer/>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        @click="clear"
        @keypress.enter="clear"
        v-text="'Reset'"
      />
      <v-btn
        color="primary lighten-1"
        tabindex="0"
        :disabled="loading || !form"
        @click="submit"
        @keypress.enter="submit"
        v-text="mode == 'add' ? 'Add' : 'Update'"
      />
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import find from 'lodash/find'
import SelectTags from '@/include/SelectTags'
import SelectStatus from '@/include/SelectStatus'
import SelectCourses from '@/include/SelectCourses'
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'dialog-manage-course',
  components: {
    SelectTags,
    SelectStatus,
    SelectCourses,
    MarkdownTextarea
  },
  data: () => ({
    url: '/courses/manage',
    show: false,
    loading: false,
    form: false,
    mode: 'add',
    item: null,

    statusTypes: [
      { text: 'Activated', icon: 'check_circle', color: 'success', value: 1 },
      { text: 'Deactivated', icon: 'cancel', color: 'warning', value: 0 }
    ],

    // values
    id: null,
    title: null,
    code: null,
    description: null,
    objectives: null,
    unitsLec: null,
    unitsLab: null,
    status: null,
    tags: [],
    prerequisites: [],
    corequisites: []
  }),
  watch: {
    show(e) {
      if (!e) {
        this.clear()
      }
    }
  },

  methods: {
    addItem() {
      this.mode = 'add'
      this.item = null
      this.show = true
      this.clear()
    },
    editItem(item) {
      this.mode = 'edit'
      
      this.item = item
      this.setValuesFromItem(item)

      this.show = true
    },

    setValuesFromItem(item) {
      // set values
      this.id = item.id
      this.title = item.title
      this.code = item.code
      this.description = item.description
      this.objectives = item.objectives
      this.unitsLec = item.unitsLec
      this.unitsLab = item.unitsLab
      this.status = find(this.statusTypes, { value: Number(item.status) })
      this.tags = item.tags || []
      this.prerequisites = item.prerequisites || []
      this.corequisites = item.corequisites || []
    },

    submit() {
      if (!this.$refs.form.validate()) {
        return
      }

      let data = new FormData()

      data.append('mode', this.mode)
      data.append('title', this.title)
      data.append('code', this.code)
      data.append('description', this.description)
      data.append('objectives', this.objectives)
      data.append('unitsLec', this.unitsLec)
      data.append('unitsLab', this.unitsLab)
      data.append('status', this.status.value)

      data.append('tags', JSON.stringify(this.tags))
      data.append('prerequisites', JSON.stringify(this.prerequisites.map(e => String(e.id))))
      data.append('corequisites', JSON.stringify(this.corequisites.map(e => String(e.id))))

      if (this.mode == 'edit') {
        data.append('id', this.id)
      }

      this.loading = true
      this.$http.post(this.url, data).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }

        let msg = this.mode == 'add'
          ? 'Added course successfully.'
          : 'Updated course successfully.'
        this.$bus.$emit('snackbar--show', msg)
        this.$bus.$emit('manage--courses.update')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        let msg = this.mode == 'add'
          ? 'Unable to add course.'
          : 'Unable to update course.'
        this.$bus.$emit('snackbar--show', msg)
        this.loading = false
      })
    },

    clear() {
      if (this.$refs.form) {
        this.$refs.form.reset()
        if (typeof this.$refs.form.$el.reset === 'function') {
          this.$refs.form.$el.reset()
        }
      }

      if (this.$refs.mdDescription) {
        this.$refs.mdDescription.reset()
      }

      this.id = null
      this.title = null
      this.code = null
      this.description = null
      this.objectives = null
      this.unitsLec = null
      this.unitsLab = null
      this.unitsLab = null
      this.status = null
      this.tags = []
      this.prerequisites = []
      this.corequisites = []

      if (this.mode == 'add') {
        this.item = null
      } else if (this.mode == 'edit') {
        // set item values if edit mode
        setTimeout(() => {
          this.setValuesFromItem(this.item)
        }, 0)
      }
    }
  }
}
</script>
