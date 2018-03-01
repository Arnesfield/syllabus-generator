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

    <v-alert
      :type="alertType"
      :value="Boolean(myStatus)"
      class="mb-2"
    >
      <template
        v-if="myStatus == 'accept'"
      >You accepted this syllabus.</template>
      <template
        v-if="myStatus == 'reject'"
      >You rejected this syllabus.</template>
    </v-alert>
    
    <v-layout v-if="Boolean(myStatus) && !revealAction" class="mb-2">
      <v-btn
        block
        color="grey lighten-3"
        @click="revealAction = true"
      >Change choice</v-btn>
    </v-layout>
    <v-layout v-if="revealAction && allowAction" class="mb-2">
      <v-btn
        block
        color="success"
        class="mr-1"
        @click="doAction(1)"
      >
        <v-icon>check</v-icon>
        <span>Approve</span>
      </v-btn>
      <v-btn
        block
        color="error"
        class="ml-1"
        @click="doAction(0)"
      >
        <v-icon>close</v-icon>
        <span>Reject</span>
      </v-btn>
    </v-layout>

    <!-- do not show this if not part of reviewers or assigned -->
    <v-card class="mb-4" hover v-if="allowComment">
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
    approveRejectUrl: '/assigns/approve_reject',
    commentUrl: '/comments/comment',
    url: '/comments',
    model: null,
    comment: null,
    comments: [],

    allowComment: false,
    allowAction: false,
    myStatus: false,
    revealAction: false,
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
  computed: {
    alertType() {
      if (this.myStatus == 'accept') {
        return 'success'
      } else if (this.myStatus == 'reject') {
        return 'error'
      }
      return 'info'
    }
  },

  created() {
    this.fetch()
  },

  methods: {
    doAction(value) {
      let vm = this
      
      let title = value == 1 ? 'Approve syllabus' : 'Reject syllabus'
      let msg = value == 1 ? 'This will approve the syllabus.' : 'This will reject the syllabus.'
      let btnText = value == 1 ? 'Approve' : 'Reject'
      let btnColor = value == 1 ? 'success' : 'error'
      let snackSuccessMsg = value == 1 ? 'Approved syllabus.' : 'Rejected syllabus.'
      let snackErrorMsg = value == 1 ? 'Unable to approve syllabus.' : 'Unable to reject syllabus.'

      this.$bus.$emit('dialog--global.confirm.show', {
        item: this.assignId,
        title: title,
        msg: msg,
        btn: {
          text: btnText,
          color: btnColor
        },
        fn(onSuccess, onError, doClose, fn) {
          vm.$http.post(vm.approveRejectUrl, qs.stringify({
            assignId: vm.assignId,
            value: value
          })).then(res => {
            console.warn(res.data)
            if (!res.data.success) {
              throw new Error('Request failure.')
            }

            vm.$bus.$emit('snackbar--show', snackSuccessMsg)
            vm.fetch()
            onSuccess()
          }).catch(e => {
            console.error(e)
            vm.$bus.$emit('snackbar--show', {
              text: snackErrorMsg,
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
        this.allowAction = res.data.allowAction
        this.allowComment = res.data.allowComment
        this.myStatus = res.data.myStatus
        this.comments = res.data.comments
        // only reveal action if myStatus is false
        this.revealAction = !res.data.myStatus
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
