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
      <v-toolbar-title>Upload Users</v-toolbar-title>
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">
        <input
          type="file"
          required
          @change="onFileChange"
        >

        <csv-prop-list
          v-model="propList"
          class="mt-3"
        />
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
        :disabled="loading || !file"
        @click="submit"
        @keypress.enter="submit"
      >Upload</v-btn>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import Papa from 'papaparse'
import CsvPropList from '@/include/CsvPropList'

export default {
  name: 'dialog-csv-users',
  components: {
    CsvPropList
  },
  data: () => ({
    url: '/users/addCsv',
    show: false,
    loading: false,
    form: false,
    file: null,

    propList: [
      /* {
        name: 'id',
        type: 'Integer',
        text: 'Unique identifier.',
        required: true
      }, */
      {
        name: 'fname',
        type: 'Varchar',
        text: 'First name.',
        required: true
      },
      {
        name: 'mname',
        type: 'Varchar',
        text: 'Middle name.'
      },
      {
        name: 'lname',
        type: 'Varchar',
        text: 'Last name.',
        required: true
      },
      {
        name: 'username',
        type: 'Varchar (UNIQUE)',
        text: 'Username/Student Number.',
        required: true
      },
      {
        name: 'title',
        type: 'Varchar',
        text: 'e.g. Director of IT'
      },
      {
        name: 'weight',
        type: 'Integer',
        text: 'How high is the position'
      },
      {
        name: 'password',
        type: 'Text (in bcrpyt)',
        text: 'Password.',
        required: true
      },
      {
        name: 'img_src',
        type: 'Text',
        text: 'Name of the image. (e.g. pic.jpg)'
      },
      {
        name: 'status',
        type: 'Integer (0 or 1)',
        text: '1 if active; otherwise, 0',
        required: true
      }
    ]
  }),

  watch: {
    loading(e) {
      this.$bus.refresh(e)
    },
    show(e) {
      if (!e) {
        this.clear()
      }
    }
  },

  methods: {
    addCsv() {
      this.show = true
    },

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

      this.loading = true
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
            this.loading = false
            this.$bus.$emit('snackbar--show', 'Added users successfully.')
            this.$bus.$emit('manage--users.update')
            this.show = false
          }).catch((e) => {
            console.error(e)
            this.loading = false
            this.$bus.$emit('snackbar--show', 'Unable to add users.')
          })
        }
      })

    },
    clear() {
      if (this.$refs.form) {
        this.$refs.form.reset()
        if (typeof this.$refs.form.$el.reset === 'function') {
          this.$refs.form.$el.reset()
        }
      }

      this.file = null
    }
  }
}
</script>
