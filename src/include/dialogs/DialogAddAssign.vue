<template>
<v-dialog
  v-model="$bus.dialog.Assign.add"
  width="800"
  :overlay="false"
  :persistent="loading"
  transition="fade-transition"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn
        icon
        dark
        :disabled="loading"
        @click.native="$bus.dialog.Assign.add = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Assign</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <v-select
          label="Assign to"
          :items="selectAssigned.items"
          :loading="selectAssigned.loading"
          :searchInput.sync="assignToInput"
          :filter="userFilter"
          :hint="assigned ? assigned.username : ''"
          prepend-icon="person"
          persistent-hint
          item-value="id"
          v-model="assigned"
          autocomplete
          return-object
          debouce-search>
          <template
            slot="selection"
            slot-scope="data"
            >{{ $wrap.fullname(data.item) }}</template>
          <template slot="item" slot-scope="data">
            <v-list-tile-content>
              <v-list-tile-title v-html="$wrap.fullname(data.item)"/>
              <v-list-tile-sub-title v-html="data.item.username"/>
            </v-list-tile-content>
          </template>
        </v-select>

        <v-select
          label="Select Course"
          :items="selectCourse.items"
          :loading="selectCourse.loading"
          :searchInput.sync="courseInput"
          :filter="courseFilter"
          :hint="course ? course.title : ''"
          prepend-icon="search"
          persistent-hint
          item-text="code"
          item-value="id"
          v-model="course"
          autocomplete
          return-object
          debouce-search>
          <template slot="item" slot-scope="data">
            <v-list-tile-content>
              <v-list-tile-title v-html="data.item.code"/>
              <v-list-tile-sub-title v-html="data.item.title"/>
            </v-list-tile-content>
          </template>
        </v-select>

        <v-select
          label="Reviewers"
          :items="selectSub.items"
          :loading="selectSub.loading"
          :searchInput.sync="subInput"
          :filter="subUserFilter"
          :disabled="!(assigned && course)"
          prepend-icon="supervisor_account"
          item-value="id"
          multiple
          v-model="sub"
          autocomplete
          return-object
          debouce-search>
          <template
            slot="selection"
            slot-scope="data"
            >{{ displaySubs(data) }}</template>
          <template slot="item" slot-scope="data">
            <v-list-tile-content>
              <v-list-tile-title v-html="$wrap.fullname(data.item)"/>
              <v-list-tile-sub-title v-html="data.item.username"/>
            </v-list-tile-content>
          </template>
        </v-select>

      </v-form>

    </v-card-text>

    <!-- end of content -->

    <v-card-actions class="pa-4 bg-dim">
      <template v-if="loading">
        <v-progress-circular
          indeterminate
          :active="loading"
          color="primary"
        />
        <span style="height: auto" class="subheader px-2">Loading...</span>
      </template>
      <v-spacer/>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        @click="clear"
      >Clear</v-btn>
      <v-btn
        color="primary"
        tabindex="0"
        :disabled="loading"
        @click="submit"
      >{{ mode }}</v-btn>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'

export default {
  name: 'dialog-add-assign',
  props: {
    mode: {
      type: String,
      default: 'Add'
    }
  },
  data: () => ({
    url: '/assigns/add',
    userUrl: '/users/search',
    courseUrl: '/courses',
    formValid: false,
    assigned: null,
    sub: [],
    course: null,
    // input
    assignToInput: null,
    courseInput: null,
    subInput: null,

    // items
    selectAssigned: {
      items: [],
      loading: false,
    },
    selectSub: {
      items: [],
      loading: false
    },
    selectCourse: {
      items: [],
      loading: false
    },
    loading: false
  }),
  watch: {
    assignToInput(e) {
      this.searchUser(e ? e : '', this.selectAssigned)
    },
    subInput(e) {
      this.searchUser(e ? e : '', this.selectSub, true)
    },
    courseInput(e) {
      this.searchCourse(e ? e : '')
    },

    assigned(to, from) {
      if (to !== null && this.sub.length) {
        // check if to exists in sub
        // if yes, remove that in sub
        this.sub.every((e, i) => {
          if (e.id == to.id) {
            this.sub.splice(i, 1)
            return false
          }
          return true
        })
        this.selectSub.items.every((e, i) => {
          if (e.id == to.id) {
            this.selectSub.items.splice(i, 1)
            return false
          }
          return true
        })
      }
    }
  },

  created() {
    this.$bus.$on('watch--dialog.Assign.add', (to, from) => {
      if (to === true) {
        this.searchUser('', this.selectAssigned)
      } else {
        this.clear()
      }
    })
  },

  methods: {
    courseFilter(item, queryText, itemText) {
      const hasValue = val => val != null ? val : ''
      const lower = val => hasValue(val).toString().toLowerCase()
      
      const title = lower(item.title)
      const code = lower(item.code)
      const query = lower(queryText)
      
      return title.indexOf(query) > -1 || code.indexOf(query) > -1
    },
    userFilter(item, queryText, itemText) {
      const hasValue = val => val != null ? val : ''
      const lower = val => hasValue(val).toString().toLowerCase()
      
      const fullname = lower(this.$wrap.fullname(item))
      const username = lower(item.username)
      const query = lower(queryText)

      return fullname.indexOf(query) > -1 || username.indexOf(query) > -1
    },
    subUserFilter(item, queryText, itemText) {
      if (item.id == this.assigned.id) {
        return false
      }
      return this.userFilter(item, queryText, itemText)
    },

    displaySubs(data) {
      let items = data.parent.selectedItems
      return this.$wrap.fullname(data.item) + (items[items.length-1] !== data.item ? ', ' : '')
    },

    searchUser(search, select, isSub) {
      if (typeof isSub !== 'boolean') {
        isSub = false
      }

      // search for course if not empty
      // assume that search is not empty
      select.loading = true
      this.$http.post(this.userUrl, qs.stringify({
        search: search
      })).then((res) => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        select.items = res.data.users
        // if isSub
        if (isSub) {
          // loop throw items
          select.items.every((e, i) => {
            // remove that same id
            if (e.id == this.assigned.id) {
              select.items.splice(i, 1)
              return false
            }
            return true
          })
        }

        select.loading = false
      }).catch(e => {
        console.error(e)
        select.loading = false
      })
    },

    searchCourse(search) {
      // search for course if not empty
      // assume that search is not empty
      this.selectCourse.loading = true
      this.$http.post(this.courseUrl, qs.stringify({
        search: search
      })).then((res) => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.selectCourse.items = res.data.courses
        this.selectCourse.loading = false
      }).catch(e => {
        console.error(e)
        this.selectCourse.loading = false
      })
    },

    submit() {
      if (this.$refs.form.validate()) {
        // create content here
        let content = {
          assigned: this.assigned.id,
          course: this.course.id,
          sub: this.sub.map(e => {
            return { id: e.id, status: 2 }
          })
        }
        content = JSON.stringify(content)

        this.$http.post(this.url, qs.stringify({
          content: content
        })).then((res) => {
          console.error(res.data)
          if (!res.data.success) {
            throw new Error
          }
          this.$bus.dialog.Assign.add = false
          this.$bus.$emit('snackbar--show', 'Assigned successfully.')
          this.$bus.$emit('assign--refresh')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('snackbar--show', 'Cannot assign.')
        })
      }
    },
    clear() {
      this.$refs.form.reset()

      this.assigned = null
      this.sub = []
      this.course = null
      
      this.selectSub.items = []
      this.selectSub.loading = false

      this.selectAssigned.items = []
      this.selectAssigned.loading = false

      this.selectCourse.items = []
      this.selectCourse.loading = false

      this.loading = false
    }
  }
}
</script>
