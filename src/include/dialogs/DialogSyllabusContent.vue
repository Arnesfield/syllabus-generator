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
      <v-toolbar-title v-text="'Syllabus Content'"/>
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">

        <template v-if="syllabusContent">
          <div
            :key="i"
            v-for="(key, i) in Object.keys(contentTitle)"
          >
            <simple-title-text-card
              v-model="syllabusContent"
              :placeholder="'Enter ' + contentTitle[key].text + ' here'"
              :text="key"
              :label="contentTitle[key].text"
              :icon="contentTitle[key].icon"
              :index="i"
              fixed-title
              class="mb-3"
              required
            />
          </div>

          
          <div>
            <v-card class="mb-3">

              <v-layout align-center>
                <v-btn
                  icon
                  :ripple="false"
                >
                  <v-icon color="primary lighten-1">insert_photo</v-icon>
                </v-btn>
                <div
                  class="primary--text text--lighten-1"
                  v-text="'FEU Header Logo'"
                />
              </v-layout>
              <v-divider/>
              <div class="mr-3 pa-3">
                <v-icon class="pr-2 mr-1">insert_photo</v-icon>
                <input
                  type="file"
                  :disabled="loading"
                  @change="filesChange"
                  :name="fileName"
                  ref="file"
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
                  v-if="file && fileImgSrc"
                  class="mt-3"
                >
                  <div class="scrollable-x">
                    <v-avatar
                      tile
                      size="auto"
                      class="elevation-1"
                    >
                      <img :src="fileImgSrc"/>
                    </v-avatar>
                  </div>
                  <div class="pa-2 caption">
                    <div>
                      <strong>Image Preview</strong>
                    </div>
                    <template>
                      <div v-text="file.name"/>
                      <div v-text="$wrap.fileSize(file.size)"/>
                      <v-btn
                        color="error"
                        @click="removeFileImage"
                      >
                        <v-icon>close</v-icon>
                        <span>Remove</span>
                      </v-btn>
                    </template>
                  </div>
                </v-layout>

                <v-layout
                  v-if="imgSrc"
                  class="mt-3"
                >
                  <div class="scrollable-x">
                    <v-avatar
                      tile
                      size="auto"
                      class="elevation-1"
                    >
                      <img :src="$wrap.localImg(imgSrc)"/>
                    </v-avatar>
                  </div>
                  <div class="pa-2 caption">
                    <div>
                      <strong>Existing Image</strong>
                    </div>
                  </div>
                </v-layout>
              </div>
              
            </v-card>
          </div>

          <v-layout>
            <div class="caption">
              <em>This will be shown in Generator.</em>
              <div>
                <span>Last updated in</span>
                <strong v-text="$moment.unix(lastUpdated).format('MMMM DD, YYYY h:mmA')"/>.
              </div>
            </div>
          </v-layout>

        </template>

        <manage-no-data
          v-else
          :fetch="fetch"
          :loading="loading"
          msg="Unable to load syllabus content :("
        />

      </v-form>
    </v-card-text>

    <v-divider/>
    <v-card-actions>
      <v-spacer/>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        @click="show = false"
        @keypress.enter="show = false"
        v-text="'Cancel'"
      />
      <v-btn
        color="primary lighten-1"
        tabindex="0"
        :disabled="loading || !form || !syllabusContent"
        @click="submit"
        @keypress.enter="submit"
        v-text="'Update'"
      />
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import ManageNoData from '@/include/ManageNoData'
import SimpleTitleTextCard from '@/include/SimpleTitleTextCard'

export default {
  name: 'dialog-syllabus-content',
  components: {
    ManageNoData,
    SimpleTitleTextCard
  },
  data: () => ({
    url: '/settings/syllabus_content',
    updateUrl: '/settings/update',
    show: null,
    loading: false,
    form: false,

    syllabusContent: null,
    imgSrc: null,
    lastUpdated: null,

    file: null,
    fileName: 'file',
    fileError: null,
    fileImgSrc: null,

    contentTitle: {
      institutionVision: {
        icon: 'visibility',
        text: 'Institution Vision Statement'
      },
      institutionMission: {
        icon: 'done_all',
        text: 'Institution Mission Statement'
      },
      departmentVision: {
        icon: 'visibility',
        text: 'Department Vision Statement'
      },
      departmentMission: {
        icon: 'done_all',
        text: 'Department Mission Statement'
      },
      programEducationalObjectives: {
        icon: 'done_all',
        text: 'Program Educational Objectives'
      }
    }
  }),

  watch: {
    show(e) {
      e ? this.fetch() : this.clear()
    }
  },

  methods: {
    fetch() {
      this.loading = true
      this.$http.post(this.url).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.syllabusContent = res.data.syllabusContent.content
        this.imgSrc = this.syllabusContent.imgSrc || null
        this.lastUpdated = res.data.syllabusContent.updated_at
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
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
        this.fileImgSrc = e.target.result
      }
      reader.readAsDataURL(this.file)
    },

    removeFileImage() {
      if (this.$refs.file) {
        this.$refs.file.value = ''
      }
      this.file = null
      this.fileImgSrc = null
      this.fileError = null
    },

    submit() {
      if (!this.$refs.form.validate()) {
        return
      }

      let data = new FormData()
      data.append('name', 'syllabusContent')
      data.append('content', JSON.stringify(this.syllabusContent))

      // if file exists
      if (this.file) {
        data.append('file', this.file)
      }

      this.loading = true
      this.$http.post(this.updateUrl, data).then(res => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.$bus.$emit('snackbar--show', 'Updated syllabus content.')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        this.$bus.$emit('snackbar--show', 'Unable to update syllabus content.')
        this.loading = false
      })
    },

    clear() {
      this.syllabusContent = null
      this.removeFileImage()
    }
  }
}
</script>
