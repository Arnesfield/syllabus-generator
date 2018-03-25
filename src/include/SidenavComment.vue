<template>
<v-navigation-drawer
  app
  fixed
  :mini-variant="false"
  :clipped="true"
  width="380"
  v-model="$bus.toolbar.comments.model"
  right
  style="padding-bottom: 0"
  class="grey lighten-4"
>

  <v-toolbar
    flat
    tabs
    color="white"
  >
    <v-toolbar-title v-html="'Comments'"/>
    <v-spacer/>
    <btn-refresh tip="bottom"/>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.toolbar.comments.model = false"
      >
        <v-icon>chevron_right</v-icon>
      </v-btn>
      <span>Hide</span>
    </v-tooltip>

    <v-tabs
      show-arrows
      v-model="tabs"
      slot="extension"
      v-if="assign && levels"
    >
      <v-tab
        :key="level"
        :disabled="loading"
        v-for="level in levels.length"
      >Lvl{{ level }}</v-tab>
    </v-tabs>
  </v-toolbar>

  <v-container
    fluid
    class="pb-0"
    v-if="assign && (assign.status == 0 || assign.status == 1)"
  >
    <v-alert
      :icon="statusAlertProp.icon"
      :type="statusAlertProp.type"
      :value="true"
      class="mb-2"
    >
      <template
        v-if="assign.status == 1"
      >This syllabus is <strong>approved</strong> :)</template>
      <template
        v-else-if="assign.status == 0"
      >This syllabus is <strong>disapproved</strong> :(</template>
    </v-alert>
    <v-divider/>
  </v-container>

  <v-tabs-items v-model="tabs">
    <v-tab-item
      :key="i"
      v-for="(level, i) in levels"
    >
      <v-container fluid>
        <v-alert
          :type="alertProp(i).type"
          :icon="alertProp(i).icon"
          :value="Boolean(myStatus[i])"
          class="mb-2 grey--text"
          color="grey lighten-5"
        >
          <template
            v-if="myStatus[i] == 'approve'"
          >You <strong>approved</strong> this syllabus.</template>
          <template
            v-else-if="myStatus[i] == 'disapprove'"
          >You <strong>disapproved</strong> this syllabus.</template>
        </v-alert>
        
        <v-layout
          class="mb-2"
          v-if="Boolean(myStatus[i]) && revealAction && !revealAction[i]"
        >
          <v-btn
            block
            color="grey lighten-3"
            @click="$set(revealAction, i, true)"
          >Change choice</v-btn>
        </v-layout>
        <v-layout v-if="revealAction && revealAction[i] && allowAction[i]" class="mb-2">
          <v-btn
            block
            color="success"
            class="mr-1"
            @click="doAction(1, i)"
          >
            <v-icon>check</v-icon>
            <span>Approve</span>
          </v-btn>
          <v-btn
            block
            color="error"
            class="ml-1"
            @click="doAction(0, i)"
          >
            <v-icon>close</v-icon>
            <span>Disapprove</span>
          </v-btn>
        </v-layout>

        <!-- do not show this if not part of reviewers or assigned -->
        <v-card class="mb-4 non-clickable" hover v-if="allowComment[i] && comment">
          <v-card-text class="pt-0 pb-2">
            <v-text-field
              placeholder="Enter comment"
              v-model="comment[i]"
              class="multi-line-textarea"
              multi-line
              :disabled="commentLoading[i]"
              :loading="commentLoading[i]"
              :error-messages="commentError[i]"
            />
          </v-card-text>
          <v-card-actions class="pt-0">
            <div class="full-width" style="display: flex">
              <v-spacer/>
              <v-btn
                :disabled="!comment[i]"
                color="primary"
                @click="doComment(i)"
                :loading="commentLoading[i]"
              >Comment</v-btn>
            </div>
          </v-card-actions>
        </v-card>

        <template v-if="comments.length">
          <comment-inst
            :key="j"
            v-for="(item, j) in comments"
            v-if="item.level == i"
            :item="item"
            @delete="deleteComment(item)"
          />
        </template>
        <template v-else>
          <v-layout justify-center>
            <manage-no-data
              :fetch="fetch"
              :loading="loading"
              msg="No comments yet :("
            />
          </v-layout>
        </template>
      </v-container>
    </v-tab-item>
  </v-tabs-items>

</v-navigation-drawer>
</template>

<script>
import qs from 'qs'
import BtnRefresh from '@/include/BtnRefresh'
import CommentInst from '@/include/CommentInst'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'sidenav-comment',
  props: {
    assignId: [Number, String],
    level: [Number, String]
  },
  components: {
    BtnRefresh,
    CommentInst,
    ManageNoData
  },
  data: () => ({
    approvalActionUrl: '/assigns/approval_action',
    commentUrl: '/comments/comment',
    url: '/comments',
    comment: [],
    comments: [],
    tabs: 0,

    assign: null,
    allowComment: [],
    allowAction: [],
    myStatus: [],
    revealAction: [],
    commentError: [],
    commentLoading: [],
    loading: false
  }),
  watch: {
    loading(e) {
      this.$bus.refresh(e)
    },
    comment(to, from) {
      // loop through comment
      if (!from) {
        return
      }

      to.forEach((e, i) => {
        // if changed based on from, set commentError to undefined
        if (e != from[i]) {
          this.commentError[i] = undefined
        }
      })
    },
    level(e) {
      this.setInitial()
    }
  },
  computed: {
    statusAlertProp() {
      if (this.assign) {
        if (this.assign.status == 0) {
          return { type: 'error', icon: 'cancel' }
        } else if (this.assign.status == 1) {
          return { type: 'success', icon: 'check_circle' }
        }
      }
      return { type: 'info', icon: 'info' }
    },

    levels() {
      return this.assign && this.assign.content
        ? this.assign.content.levels || []
        : []
    }
  },

  created() {
    this.$bus.$on('refresh--btn', this.fetch)
    this.$bus.$on('syllabus--info.show', this.infoShow)
    this.setInitial()
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
    this.$bus.$off('syllabus--info.show', this.infoShow)
  },

  methods: {
    setInitial() {
      this.tabs = String(this.level ? Number(this.level)-1 : 0)
    },

    infoShow() {
      if (!this.assign) {
        return
      }
      this.$bus.$emit('dialog--detailed-workflow.show', this.assign, Number(this.tabs)+1)
    },

    alertProp(i) {
      if (this.myStatus[i] == 'approve') {
        return { type: 'success', icon: 'check_circle' }
      } else if (this.myStatus[i] == 'disapprove') {
        return { type: 'error', icon: 'cancel' }
      }
      return { type: 'info', icon: 'info' }
    },

    doAction(value, i) {
      
      let snackSuccessMsg = value == 1 ? 'Syllabus approved.' : 'Syllabus disapproved.'
      let snackErrorMsg = value == 1 ? 'Unable to approve syllabus.' : 'Unable to disapprove syllabus.'

      this.$http.post(this.approvalActionUrl, qs.stringify({
        assignId: this.assignId,
        value: value,
        level: i
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }

        this.$bus.$emit('snackbar--show', snackSuccessMsg)
        this.fetch()
      }).catch(e => {
        console.error(e)
        this.$bus.$emit('snackbar--show', {
          text: snackErrorMsg,
          btns: {
            text: 'Retry',
            icon: false,
            color: 'accent',
            cb: (sb, e) => {
              sb.snackbar = false
              // fn(onSuccess, onError, doClose, fn)
              this.doAction(value, i)
            }
          }
        })
      })
    },

    deleteComment(item) {
      this.$bus.$emit('dialog--global.confirm.show', {
        item: item,
        title: 'Delete comment',
        msg: 'This will permanently delete the comment.',
        btn: {
          text: 'Delete',
          color: 'error'
        },
        fn: (onSuccess, onError, doClose, fn) => {
          this.$http.post('/comments/delete', qs.stringify({
            id: item.id
          })).then(res => {
            console.warn(res.data)
            if (!res.data.success) {
              throw new Error('Request failure.')
            }

            this.$bus.$emit('snackbar--show', 'Comment deleted.')
            this.fetch()
            onSuccess()
          }).catch(e => {
            console.error(e)
            this.$bus.$emit('snackbar--show', {
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

    doComment(i) {
      this.commentLoading[i] = true
      this.$http.post(this.commentUrl, qs.stringify({
        assignId: this.assignId,
        comment: this.comment[i],
        level: i
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        // modify commentError first
        this.commentError[i] = undefined
        this.commentLoading[i] = false
        this.comment[i] = null
        this.fetch()
      }).catch(e => {
        console.error(e)
        this.commentError[i] = 'Unable to submit comment.'
        this.commentLoading[i] = false
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
        this.assign = res.data.assign
        this.allowAction = res.data.allowAction
        this.allowComment = res.data.allowComment
        this.myStatus = res.data.myStatus
        this.comments = res.data.comments
        this.revealAction = res.data.revealAction
        
        // based on the number of levels, push to comment related data
        let l = this.levels.length
        // but first, clear these values first
        this.commentError = []
        this.commentLoading = []
        this.comment = []
        do {
          // make sure to push comment error first
          this.commentError.push(undefined)
          this.commentLoading.push(false)
          this.comment.push(null)
          l--
        } while (l > 0)

        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
