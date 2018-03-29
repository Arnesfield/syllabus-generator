<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="fade-transition"
  width="640"
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
      <v-toolbar-title v-text="'CLO Options'"/>
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">

        <template v-if="cloOptions.length">
          <v-layout
            row
            wrap
            align-center
            :key="i"
            v-for="(clo, i) in cloOptions"
          >
            
            <v-tooltip top>
              <v-btn
                icon
                flat
                small
                color="error"
                slot="activator"
                @click="cloOptions.splice(i, 1)"
                :disabled="loading || cloOptions.length == 1"
              >
                <v-icon small>close</v-icon>
              </v-btn>
              <span>Remove</span>
            </v-tooltip>

            <div>
              <v-text-field
                label="Symbol"
                v-model="clo.symbol"
                :disabled="loading"
                :rules="[$fRule('required')]"
                required
              />
            </div>

            <v-text-field
              label="Description"
              class="ml-1"
              v-model="clo.text"
              :disabled="loading"
              :rules="[$fRule('required')]"
              required
            />

          </v-layout>
        </template>

        <manage-no-data
          v-else
          :fetch="fetch"
          :loading="loading"
          msg="Unable to load CLO options :("
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
        @click="addItem"
        @keypress.enter="addItem"
        :disabled="loading"
      >Add</v-btn>
      <v-btn
        color="primary lighten-1"
        tabindex="0"
        :disabled="loading || !form || cloOptions.length == 0"
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

export default {
  name: 'dialog-clo-options',
  components: {
    ManageNoData
  },
  data: () => ({
    url: '/settings/clo_options',
    updateUrl: '/settings/update',
    show: null,
    loading: false,
    form: false,

    cloOptions: []
  }),

  watch: {
    show(e) {
      e ? this.fetch() : this.clear()
    }
  },

  methods: {
    addItem() {
      this.cloOptions.push({
        symbol: null,
        text: null
      })
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.cloOptions = res.data.cloOptions.content
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
      data.append('name', 'cloOptions')
      data.append('content', JSON.stringify(this.cloOptions))

      this.loading = true
      this.$http.post(this.updateUrl, data).then(res => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.$bus.$emit('snackbar--show', 'Updated CLO options.')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        this.$bus.$emit('snackbar--show', 'Unable to updated CLO options.')
        this.loading = false
      })
    },

    clear() {
      this.cloOptions = []
    }
  }
}
</script>
