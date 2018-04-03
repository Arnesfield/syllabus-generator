<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="fade-transition"
  width="1080"
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
      <v-toolbar-title v-text="'Grading System'"/>
      <v-spacer/>
      <v-btn
        icon
        dark
        :disabled="loading"
        @click="add"
        @keypress.enter="add"
      >
        <v-icon>add</v-icon>
      </v-btn>
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">

        <template v-if="gradingSystem.length">
          <v-container
            fluid
            grid-list-lg
            class="pa-0 mb-3"
          >
            <v-layout row wrap>
              <v-flex
                xs12
                sm6
                :key="i"
                v-for="(item, i) in gradingSystem"
              >
                <simple-title-text-card
                  v-model="gradingSystem[i]"
                  label-text="Enter label (e.g. Midterm Exam, etc.)"
                  placeholder="Enter grading system"
                  icon="grade"
                  :index="i"
                  removable
                  required
                  @remove="remove"
                />
              </v-flex>
            </v-layout>
          </v-container>

          <v-layout>
            <div class="caption">
              <em>This will be suggested in Generator.</em>
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
          msg="No grading system available :("
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
        outline
        tabindex="0"
        color="primary lighten-1"
        @click="add"
        @keypress.enter="add"
        :disabled="loading"
      >Add</v-btn>
      <v-btn
        color="primary lighten-1"
        tabindex="0"
        :disabled="loading || !form || gradingSystem.length == 0"
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
  name: 'dialog-grading-system',
  components: {
    ManageNoData,
    SimpleTitleTextCard
  },
  data: () => ({
    url: '/settings/grading_system',
    updateUrl: '/settings/update',
    show: null,
    loading: false,
    form: false,

    gradingSystem: [],
    lastUpdated: null
  }),

  watch: {
    show(e) {
      e ? this.fetch() : this.clear()
    }
  },

  methods: {
    add() {
      this.gradingSystem.push({
        label: null,
        text: 'Enter grading here'
      })
    },
    remove(i) {
      this.gradingSystem.splice(i, 1)
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.gradingSystem = res.data.gradingSystem.content
        this.lastUpdated = res.data.gradingSystem.updated_at
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    },

    submit() {
      if (!this.$refs.form.validate()) {
        return
      }

      let data = new FormData()
      data.append('name', 'gradingSystem')
      data.append('content', JSON.stringify(this.gradingSystem))

      this.loading = true
      this.$http.post(this.updateUrl, data).then(res => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.$bus.$emit('snackbar--show', 'Updated grading system.')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        this.$bus.$emit('snackbar--show', 'Unable to update grading system.')
        this.loading = false
      })
    },

    clear() {
      this.gradingSystem = []
    }
  }
}
</script>
