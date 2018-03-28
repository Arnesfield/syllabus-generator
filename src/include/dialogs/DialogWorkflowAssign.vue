<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="fade-transition"
  width="640"
  scrollable
>
  <v-card v-if="item">

    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      background-color="primary lighten-1"
      class="ma-0 primary lighten-1"
    />

    <v-layout
      class="primary lighten-1"
      style="min-height: 48px"
    >
      <v-btn
        dark
        icon
        :disabled="loading"
        @click.native="show = false"
        @keypress.enter="show = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-tabs
        dark
        show-arrows
        v-model="tabs"
        color="primary lighten-1"
        style="width: calc(100% - 64px)"
      >
        <v-tab :disabled="loading">Info</v-tab>
        <!-- loop levels -->
        <v-tab
          :key="level"
          :disabled="loading"
          v-for="level in item.levels.length"
        >Lvl{{ level }}</v-tab>
      </v-tabs>
    </v-layout>

    <v-card-text style="overflow-x: hidden">
      <v-form ref="form" v-model="form">
        <v-tabs-items v-model="tabs">
          <v-tab-item>
            <workflow-info
              v-model="item"
              :loading="loading"
            />
          </v-tab-item>
          <!-- loop levels -->
          <v-tab-item
            :key="i"
            v-for="(level, i) in item.levels"
          >
            <workflow-level
              :index="i"
              v-model="item.levels[i]"
              :loading="loading"
            />
          </v-tab-item>
        </v-tabs-items>
      </v-form>
    </v-card-text>

    <v-divider/>
    <v-card-actions>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        v-if="tabs == 0"
        @click="show = false"
        @keypress.enter="show = false"
        v-text="'Cancel'"
      />
      <v-btn
        flat
        tabindex="0"
        color="primary"
        :disabled="loading"
        @click="tabs = 0"
        v-if="Number(tabs) > 0"
        @keypress.enter="tabs = 0"
        v-text="'Info'"
      />
      <v-spacer/>
      <v-tooltip
        top
        class="mx-0"
        v-if="tabs > 0"
      >
        <v-btn
          flat
          icon
          tabindex="0"
          slot="activator"
          :disabled="loading"
          @click="tabs = tabs-1"
          @keypress.enter="tabs = tabs-1"
        >
          <v-icon>keyboard_arrow_left</v-icon>
        </v-btn>
        <span v-if="Number(tabs)-1 > 0">Level {{ Number(tabs)-1 }}</span>
        <span v-else>Info</span>
      </v-tooltip>
      <v-tooltip
        top
        class="mx-0"
        v-if="Number(tabs) < item.levels.length"
      >
        <v-btn
          flat
          icon
          tabindex="0"
          slot="activator"
          :disabled="loading"
          @click="tabs = Number(tabs)+1"
          @keypress.enter="tabs = Number(tabs)+1"
        >
          <v-icon>keyboard_arrow_right</v-icon>
        </v-btn>
        <span>Level {{ Number(tabs)+1 }}</span>
      </v-tooltip>
      <v-tooltip top>
        <v-btn
          icon
          :dark="valid"
          tabindex="0"
          :color="valid ? 'primary lighten-1' : 'grey lighten-2'"
          slot="activator"
          :disabled="loading || !valid"
          @click="submit"
          @keypress.enter="submit"
        >
          <v-icon>done</v-icon>
        </v-btn>
        <span>Finish and save</span>
      </v-tooltip>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import WorkflowInfo from '@/include/assign/WorkflowInfo'
import WorkflowLevel from '@/include/assign/WorkflowLevel'

export default {
  name: 'dialog-workflow-assign',
  components: {
    WorkflowInfo,
    WorkflowLevel
  },
  data: () => ({
    url: '/assigns/add',
    show: false,
    item: null,
    tabs: 0,
    mode: 'add',
    loading: false,
    form: false
  }),
  computed: {
    valid() {
      // check item here
      let item = this.item
      if (!item || !item.course || !item.assigned) {
        return false
      }

      // check through levels
      return item.levels.every(e => e.users && e.users.length > 0)
    }
  },
  watch: {
    show(e) {
      if (!e) {
        // clear data
        this.clear()
      }
    },
    item: {
      deep: true,
      handler(to, from) {
        
      }
    }
  },
  methods: {
    clear() {
      this.tabs = 0
      this.item = null
      this.loading = false
    },

    activate(item, options) {
      if (typeof options !== 'undefined' && options !== null) {
        this.mode = options.mode || 'add'
      }

      if (typeof item === 'undefined' || item === null) {
        // create item instead
        item = {
          assigned: null,
          course: null,
          remarks: null,
          levels: [{}, {}, {}]
        }
      }
      this.show = true
      this.item = item
    },

    submit() {
      if (!this.valid) {
        return
      }

      let content = JSON.stringify(this.createItem(this.item))
      this.$http.post(this.url, qs.stringify({
        content: content
      })).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error
        }
        this.$bus.$emit('snackbar--show', 'Workflow created.')
        this.$bus.$emit('refresh--btn')
        this.show = false
      }).catch((e) => {
        console.error(e)
        this.$bus.$emit('snackbar--show', {
          text: 'Unable to create workflow.',
          btns: {
            text: 'Retry',
            icon: false,
            color: 'accent',
            cb: (sb, e) => {
              this.submit()
              sb.snackbar = false
            }
          }
        })
      })
    },

    createItem(item) {
      let myItem = {}
      myItem.assigned = {
        id: Number(item.assigned.id),
        status: 2
      }
      myItem.course = Number(item.course.id)
      myItem.remarks = item.remarks
      myItem.levels = item.levels.map(e =>
        e.users.map(f => ({
          id: Number(f.id),
          status: 2
        }))
      )
      return myItem
    }
  }
}
</script>
