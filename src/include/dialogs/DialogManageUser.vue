<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="fade-transition"
  width="800"
  scrollable
>
  <v-card v-if="show">
    
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
        v-text="mode == 'add' ? 'Add User' : 'Update User'"
      />
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">

        <!-- name -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Name</v-subheader>
          </v-flex>
          <v-flex sm8>
            
            <v-layout row wrap>
              <!-- <v-flex xs12 sm6> -->
                <v-text-field
                  label="First name"
                  prepend-icon="person"
                  v-model="fname"
                  color="primary lighten-1"
                  :disabled="loading"
                  :rules="[$fRule('required')]"
                  required
                />
                &nbsp;
                <v-text-field
                  label="Middle name"
                  color="primary lighten-1"
                  v-model="mname"
                  :disabled="loading"
                />
              <!-- </v-flex> -->
            </v-layout>

            <v-text-field
              label="Last name"
              color="primary lighten-1"
              v-model="lname"
              prepend-icon="person_outline"
              :disabled="loading"
              :rules="[$fRule('required')]"
              required
            />
          </v-flex>
        </v-layout>

        <!-- username -->

        <v-layout align-center>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Username</v-subheader>
          </v-flex>
          <v-flex sm8>
            <v-text-field
              label="Username"
              color="primary lighten-1"
              v-model="username"
              :disabled="loading"
              prepend-icon="account_circle"
              :rules="[$fRule('required')]"
              required
            />
          </v-flex>
        </v-layout>

        <!-- title -->

        <v-layout align-center>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Title</v-subheader>
          </v-flex>
          <v-flex sm8>
            <v-layout>
              <v-text-field
                label="Title"
                color="primary lighten-1"
                v-model="title"
                :disabled="loading"
                prepend-icon="format_list_numbered"
                :rules="[$fRule('required')]"
                required
              />
              &nbsp;
              <div style="width: 128px">
                <v-text-field
                  label="Weight"
                  type="number"
                  color="primary lighten-1"
                  v-model="weight"
                  :disabled="loading"
                  :rules="[$fRule('required'), $fRule('min', null, 0), $fRule('max', null, 20)]"
                  required
                />
              </div>
            </v-layout>
          </v-flex>
        </v-layout>

        <!-- password -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Password</v-subheader>
          </v-flex>
          <v-flex sm8>

            <v-checkbox
              class="mt-2"
              color="primary lighten-1"
              label="Change password"
              :disabled="mode == 'add' || loading"
              :hint="alsoPassword ? 'Note: Current password will be overwritten!' : undefined"
              persistent-hint
              v-if="mode == 'edit'"
              v-model="alsoPassword"
            />

            <template v-if="alsoPassword">

              <v-tooltip v-if="defaultPass" top>
                <v-btn
                  icon
                  slot="activator"
                  color="primary lighten-1"
                  @click="defaultPass = !defaultPass"
                >
                  <v-icon small>edit</v-icon>
                </v-btn>
                <span>Edit</span>
              </v-tooltip>
              
              <v-btn
                v-else
                :dark="!defaultPass"
                :color="!defaultPass ? 'primary lighten-1' : undefined"
                @click="defaultPass = !defaultPass"
              >Use default</v-btn>
            
              <template
                v-if="defaultPass"
              >The default password is
                <strong
                  class="mono primary lighten-1 white--text pa-1"
                  v-text="defaultPassText"
                />
              </template>

              <template v-else>
                <v-text-field
                  label="Password"
                  color="primary lighten-1"
                  v-model="password"
                  prepend-icon="lock"
                  :disabled="loading"
                  :type="hidePass.password ? 'password' : 'text'"
                  :append-icon="hidePass.password ? 'visibility' : 'visibility_off'"
                  :append-icon-cb="() => (hidePass.password = !hidePass.password)"
                  hint="Password must be at least 6 up to 13 characters!"
                  :rules="[$fRule('required'), $fRule('password')]"
                  required
                />

                <v-text-field
                  label="Confirm Password"
                  color="primary lighten-1"
                  v-model="passconf"
                  prepend-icon="lock_outline"
                  :disabled="loading"
                  :type="hidePass.passconf ? 'password' : 'text'"
                  :append-icon="hidePass.passconf ? 'visibility' : 'visibility_off'"
                  :append-icon-cb="() => (hidePass.passconf = !hidePass.passconf)"
                  :rules="[$fRule('match', undefined, password)]"
                />
              </template>

            </template>
          </v-flex>
        </v-layout>

        <!-- preferences -->

        <v-layout align-content-start class="mt-2">
          <v-flex hidden-xs-only sm4>
            <v-subheader>Preferences</v-subheader>
          </v-flex>
          <v-flex sm8>
            <select-privileges
              ref="selectPrivileges"
              color="primary lighten-1"
              v-model="auth"
              :disabled="loading"
              required
            />
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

        <!-- image -->

        <v-layout>
          <v-flex hidden-xs-only sm4>
            <v-subheader>
              <div>
                <div>Profile image</div>
                <div class="caption" v-text="'(jpg, jpeg, png)'"/>
              </div>
            </v-subheader>
          </v-flex>
          <v-flex sm8 class="py-2 mt-1">
            <v-icon class="pr-2 mr-1">insert_photo</v-icon>
            <input
              type="file"
              :disabled="loading"
              @change="filesChange"
              :name="fileName"
            />
            
            <v-layout
              v-if="fileError"
              class="red--text pa-2"
              align-center
            >
              <v-icon color="warning">cancel</v-icon>
              <div class="ml-2">{{ fileError }}</div>
            </v-layout>

            <v-layout
              v-if="imgSrc"
              class="mt-3"
            >
              <v-avatar
                tile
                size="128"
                class="elevation-1"
              >
                <img :src="file ? imgSrc : $wrap.localImg(imgSrc)"/>
              </v-avatar>
              <div class="pa-2 caption">
                <div>
                  <strong>
                    <template v-if="file">Image Preview</template>
                    <template v-else>Existing Image</template>
                  </strong>
                </div>
                <template v-if="file">
                  <div v-text="file.name"/>
                  <div v-text="$wrap.fileSize(file.size)"/>
                </template>
              </div>
            </v-layout>
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
import SelectPrivileges from '@/include/SelectPrivileges'

export default {
  name: 'dialog-manage-user',
  components: {
    SelectTags,
    SelectStatus,
    SelectPrivileges
  },
  data: () => ({
    url: '/users/manage',
    show: false,
    loading: false,
    form: false,
    mode: 'add',
    defaultPassText: '123Qwe!',
    defaultPass: true,
    alsoPassword: false,
    hidePass: {
      password: true,
      passconf: true
    },
    item: null,

    file: null,
    fileName: 'file',
    fileError: null,
    statusTypes: [
      { text: 'Activated', icon: 'check_circle', color: 'success', value: 1 },
      { text: 'Deactivated', icon: 'cancel', color: 'warning', value: 0 }
    ],

    // values
    id: null,
    fname: null,
    mname: null,
    lname: null,
    imgSrc: null,
    username: null,
    title: null,
    weight: null,
    password: null,
    passconf: null,
    status: null,
    auth: [],
    tags: []
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
      this.defaultPass = true
      this.alsoPassword = true
      this.item = null
      this.show = true
      this.clear()
    },
    editItem(item) {
      this.mode = 'edit'
      
      this.item = item
      this.setValuesFromItem(item)

      this.defaultPass = true
      this.alsoPassword = false
      this.show = true
    },

    setValuesFromItem(item) {
      // set values
      this.id = item.id
      this.fname = item.fname
      this.mname = item.mname
      this.lname = item.lname
      this.username = item.username
      this.title = item.title
      this.weight = item.weight
      this.status = find(this.statusTypes, { value: Number(item.status) })
      this.tags = item.tags || []

      if (this.$refs.selectPrivileges) {
        this.auth = this.$refs.selectPrivileges.formatRaw(item.auth)
      }
    },

    filesChange(e) {
      let f = e.target
      if (!(f.files && f.files.item(0))) {
        this.file = null
        return
      }

      const validImageTypes = ['image/jpg', 'image/jpeg', 'image/png']

      let file = f.files.item(0)
      let fileType = file['type']

      if (!validImageTypes.includes(fileType)) {
        this.fileError = 'File is not an image.'
        return
      }
      this.fileError = null

      this.file = file
      let reader = new FileReader()

      reader.onload = (e) => {
        this.imgSrc = e.target.result
      }
      reader.readAsDataURL(this.file)
    },

    submit() {
      if (!this.$refs.form.validate()) {
        return
      }

      let data = new FormData()

      data.append('mode', this.mode)
      data.append('fname', this.fname)
      data.append('mname', this.mname)
      data.append('lname', this.lname)
      data.append('username', this.username)
      data.append('title', this.title)
      data.append('weight', this.weight)
      data.append('status', this.status.value)

      data.append('alsoPassword', this.alsoPassword)
      
      data.append('tags', JSON.stringify(this.tags))
      data.append('auth', JSON.stringify(this.auth.map(e => String(e.value))))

      if (this.mode == 'edit') {
        data.append('id', this.id)
      }

      if (this.alsoPassword) {
        if (this.defaultPass) {
          data.append('password', this.defaultPassText)
        } else {
          data.append('password', this.password)
        }
      }

      if (this.file) {
        data.append('file', this.file)
      }

      this.loading = true
      this.$http.post(this.url, data).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          if (res.data.error) {
            this.$bus.$emit('snackbar--show', res.data.error)
          }
          throw new Error('Request failure.')
        }
        
        if (res.data.sess) {
          this.$bus.sessionCheck(this.$route, this.$http)
        }

        let msg = this.mode == 'add'
          ? 'Added user successfully.'
          : 'Updated user successfully.'
        this.$bus.$emit('snackbar--show', msg)
        this.$bus.$emit('manage--users.update')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        let msg = this.mode == 'add'
          ? 'Unable to add user.'
          : 'Unable to update user.'
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

      this.id = null
      this.fname = null
      this.mname = null
      this.lname = null
      this.username = null
      this.title = null
      this.weight = null
      this.password = null
      this.passconf = null
      this.status = null
      this.auth = []
      this.tags = []
      this.imgSrc = null

      this.file = null
      this.fileError = null

      this.hidePass.password = true
      this.hidePass.passconf = true

      this.defaultPass = true
      this.alsoPassword = this.mode == 'add'

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
