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
        v-text="mode == 'add' ? 'Add Outcome' : 'Update Outcome'"
      />
      <template v-if="mode == 'edit'">
        <v-spacer/>
        <v-tooltip top>
          <v-btn
            icon
            dark
            slot="activator"
            :disabled="loading"
            @click="deleteItem"
            @keypress.enter="deleteItem"
          >
            <v-icon>delete</v-icon>
          </v-btn>
          <span>Delete</span>
        </v-tooltip>
      </template>
    </v-toolbar>

    <v-card-text>
      <v-form ref="form" v-model="form">

        <!-- content -->

        <v-layout align-content-start>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Content</v-subheader>
          </v-flex>
          <v-flex sm8>
            <markdown-textarea
              :md-view="false"
              edit-on-click
              v-model="content"
              placeholder="Enter outcome content"
              t-add-class="my-medium-textarea pa-2"
              ref="mdContent"
              required
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

        <!-- type -->

        <v-layout align-center>
          <v-flex hidden-xs-only sm4>
            <v-subheader>Type</v-subheader>
          </v-flex>
          <v-flex sm8>
            <select-status
              v-model="type"
              :items="types"
              :loading="loading"
              label="Outcome Type"
              required
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

        <v-layout v-if="lastUpdated">
          <div class="caption">
            <em>This will be suggested in Generator.</em>
            <div>
              <span>Last updated in</span>
              <strong v-text="$moment.unix(lastUpdated).format('MMMM DD, YYYY h:mmA')"/>.
            </div>
          </div>
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
import qs from 'qs'
import find from 'lodash/find'
import SelectTags from '@/include/SelectTags'
import SelectStatus from '@/include/SelectStatus'
import MarkdownTextarea from '@/include/MarkdownTextarea'

export default {
  name: 'dialog-manage-outcome',
  components: {
    SelectTags,
    SelectStatus,
    MarkdownTextarea
  },
  data: () => ({
    url: '/outcomes/manage',
    deleteUrl: '/outcomes/delete',
    show: false,
    loading: false,
    form: false,
    mode: 'add',
    item: null,

    lastUpdated: null,

    statusTypes: [
      { text: 'Activated', icon: 'check_circle', color: 'success', value: 1 },
      { text: 'Deactivated', icon: 'cancel', color: 'warning', value: 0 }
    ],
    types: [
      { text: 'Course Learning Outcomes (CLO)', icon: 'notes', color: 'primary lighten-1', value: 1 },
      { text: 'Intended Learning Ouctomes (ILO)', icon: 'short_text', color: 'blue', value: 2 },
      { text: 'Faculty: Teaching and Learning Activities (TLA)', icon: 'school', color: 'accent', value: 3 },
      { text: 'Student: Teaching and Learning Activities (TLA)', icon: 'assignment', color: 'warning', value: 4 }
    ],

    // values
    id: null,
    content: null,
    type: null,
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
    deleteItem() {
      let item = this.item
      this.$bus.$emit('dialog--global.confirm.show', {
        item: item,
        title: 'Delete outcome',
        msg: 'This will permanently delete the outcome.',
        btn: {
          text: 'Delete',
          color: 'error'
        },
        fn: (onSuccess, onError, doClose, fn) => {
          this.$http.post(this.deleteUrl, qs.stringify({
            id: item.id
          })).then(res => {
            console.warn(res.data)
            if (!res.data.success) {
              throw new Error('Request failure.')
            }

            this.$bus.$emit('snackbar--show', 'Outcome deleted.')
            this.$bus.$emit('manage--outcome.update')
            this.loading = false
            this.show = false
            onSuccess()
          }).catch(e => {
            console.error(e)
            this.$bus.$emit('snackbar--show', {
              text: 'Unable to delete outcome.',
              btns: {
                text: 'Retry',
                icon: false,
                color: 'accent',
                cb: (sb, e) => {
                  sb.snackbar = false
                  fn(onSuccess, onError, doClose, fn)
                  // this.deleteComment(item)
                }
              }
            })
            onError()
            doClose()
          })
        }
      })
    },

    setValuesFromItem(item) {
      // set values
      this.id = item.id
      this.content = item.content
      this.type = find(this.types, { value: Number(item.type) })
      this.status = find(this.statusTypes, { value: Number(item.status) })
      this.tags = item.tags || []

      this.lastUpdated = Number(item.updated_at || item.created_at)
    },

    submit() {
      if (!this.$refs.form.validate()) {
        return
      }

      let data = new FormData()

      data.append('mode', this.mode)
      data.append('content', this.content)
      data.append('type', this.type.value)
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
          ? 'Added outcome successfully.'
          : 'Updated outcome successfully.'
        this.$bus.$emit('snackbar--show', msg)
        this.$bus.$emit('manage--outcome.update')
        this.loading = false
        this.show = false
      }).catch(e => {
        console.error(e)
        let msg = this.mode == 'add'
          ? 'Unable to add outcome.'
          : 'Unable to update outcome.'
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

      if (this.$refs.mdContent) {
        this.$refs.mdContent.reset()
      }

      this.id = null
      this.content = null
      this.type = null
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
