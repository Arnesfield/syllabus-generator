<template>
<v-navigation-drawer
  app
  fixed
  :mini-variant="false"
  :clipped="true"
  width="380"
  v-model="model"
  right
  style="padding-bottom: 0"
  class="grey lighten-4"
>

  <v-toolbar
    flat
    color="white"
  >
    <v-toolbar-title v-html="'Comments'"/>
  </v-toolbar>

  <v-container fluid>
    <v-card class="elevation-1 mb-2">
      <v-card-text class="pt-0 pb-2">
        <v-text-field
          placeholder="Enter comment"
          v-model="comment"
          class="multi-line-textarea"
          multi-line
          :disabled="commentLoading"
          :loading="commentLoading"
          :error-messages="commentError"
        />
      </v-card-text>
      <v-card-actions class="pt-0">
        <div class="full-width" style="display: flex">
          <v-spacer/>
          <v-btn
            :disabled="!comment"
            color="primary"
            @click="doComment"
            :loading="commentLoading"
          >Comment</v-btn>
        </div>
      </v-card-actions>
    </v-card>

    <template v-if="comments.length">
      <comment-inst
        :key="i"
        v-for="(item, i) in comments"
        :item="item"
        @delete="deleteComment(item)"
      />
    </template>
    <template v-else>
      <v-layout justify-center>
        <manage-no-data
          :fetch="fetch"
          :loading="loading"
          msg="No comments :("
        />
      </v-layout>
    </template>
  </v-container>

</v-navigation-drawer>
</template>

<script>
import qs from 'qs'
import CommentInst from '@/include/CommentInst'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'sidenav-comment',
  props: {
    assignId: [Number, String]
  },
  components: {
    CommentInst,
    ManageNoData
  },
  data: () => ({
    commentUrl: '/comments/comment',
    url: '/comments',
    model: null,
    comment: null,
    comments: [],

    commentError: undefined,
    commentLoading: false,
    loading: false
  }),
  watch: {
    loading(e) {
      this.$bus.progress.active = e
    },
    comment(to, from) {
      if (to) {
        this.commentError = undefined
      }
    }
  },

  created() {
    this.fetch()
  },

  methods: {
    deleteComment(item) {
      let vm = this
      this.$bus.$emit('dialog--global.confirm.show', {
        item: item,
        title: 'Delete comment',
        msg: 'This will permanently delete the comment.',
        btn: {
          text: 'Delete',
          color: 'error'
        },
        fn(onSuccess, onError, doClose, fn) {
          vm.$http.post('/comments/delete', qs.stringify({
            id: item.id
          })).then(res => {
            console.warn(res.data)
            if (!res.data.success) {
              throw new Error('Request failure.')
            }

            vm.$bus.$emit('snackbar--show', 'Comment deleted.')
            vm.fetch()
            onSuccess()
          }).catch(e => {
            console.error(e)
            vm.$bus.$emit('snackbar--show', {
              text: 'Unable to delete comment.',
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

    doComment() {
      this.commentLoading = true
      this.$http.post(this.commentUrl, qs.stringify({
        assignId: this.assignId,
        comment: this.comment
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.comment = null
        this.commentError = undefined
        this.commentLoading = false
        this.fetch()
      }).catch(e => {
        console.error(e)
        this.commentError = 'Unable to submit comment.'
        this.commentLoading = false
      })
    },

    fetch() {
      if (typeof this.assignId === 'undefined' || this.assignId === null) {
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        assignId: this.assignId
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.comments = res.data.comments
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
