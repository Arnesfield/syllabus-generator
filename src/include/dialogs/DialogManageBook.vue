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
        v-text="mode == 'add' ? 'Add Book' : 'Update Book'"
      />
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">
        
        <!-- citation -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Citation</v-subheader>
          </v-flex>
          <v-flex sm8>
            <markdown-textarea
              :md-view="false"
              v-model="citation"
              placeholder="Enter citation"
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
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'dialog-manage-book',
  components: {
    SelectTags,
    SelectStatus,
    MarkdownTextarea
  },
  data: () => ({
    url: '/books/manage',
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
    citation: null,
    status: null,
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
      this.citation = item.citation
      this.status = find(this.statusTypes, { value: Number(item.status) })
      this.tags = item.tags || []
    },

    submit() {
      if (!this.$refs.form.validate()) {
        return
      }

      let data = new FormData()

      data.append('mode', this.mode)
      data.append('citation', this.citation)
      data.append('status', this.status.value)

      data.append('tags', JSON.stringify(this.tags))

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
          ? 'Added book successfully.'
          : 'Updated book successfully.'
        this.$bus.$emit('snackbar--show', msg)
        this.$bus.$emit('manage--books.update')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        let msg = this.mode == 'add'
          ? 'Unable to add book.'
          : 'Unable to update book.'
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
      this.citation = null
      this.status = null
      this.tags = []

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
