<template>
<div>

  <div class="mb-3">
    <v-subheader
      class="grey--text text--darken-1"
      style="font-size: 1.175rem"
      v-text="'Workflow Information'"
    />
    <v-divider/>
  </div>

  <!-- levels -->
  <v-layout row align-center>
    <v-flex
      hidden-xs-only
      sm3
    >
      <v-subheader>Levels</v-subheader>
    </v-flex>
    <v-flex
      xs12
      sm9
    >
      <v-text-field
        v-model="levels"
        type="number"
        label="Levels"
        prepend-icon="format_list_numbered"
        placeholder="Enter number of levels"
        :hint="
          !levels || levels < 1
            ? this.item.levels.length + (this.item.levels.length == 1 ? ' level' : ' levels')
            : undefined
        "
        :persistent-hint="!levels || levels < 1"
      />
    </v-flex>
  </v-layout>

  <!-- course -->
  <v-layout row align-center>
    <v-flex
      hidden-xs-only
      sm3
    >
      <v-subheader>Course</v-subheader>
    </v-flex>
    <v-flex
      xs12
      sm9
    >
      <v-btn
        color="primary lighten-1"
        @click="dialogCourse = true"
        v-if="selectedCourse === null"
      >
        <v-icon>school</v-icon>
        &nbsp;
        <span>Select course</span>
      </v-btn>
      <template v-else>
        <v-layout align-center>
          <v-tooltip top>
            <v-btn
              icon
              small
              slot="activator"
              @click="dialogCourse = true"
            >
              <v-icon
                small
                color="grey darken-1"
              >edit</v-icon>
            </v-btn>
            <span>Edit</span>
          </v-tooltip>

          <v-subheader class="pl-0">{{ selectedCourse.code }}</v-subheader>

        </v-layout>
      </template>
    </v-flex>
  </v-layout>

  <!-- assign to -->
  <v-layout row align-center>
    <v-flex
      hidden-xs-only
      sm3
    >
      <v-subheader>Assign to</v-subheader>
    </v-flex>
    <v-flex
      xs12
      sm9
    >
      <v-btn
        color="primary lighten-1"
        @click="dialogUser = true"
        v-if="selectedUser === null"
        :disabled="selectedCourse === null"
      >
        <v-icon>person</v-icon>
        &nbsp;
        <span>Select user</span>
      </v-btn>
      <template v-else>
        <v-layout align-center>
          <v-tooltip top>
            <v-btn
              icon
              small
              slot="activator"
              @click="dialogUser = true"
            >
              <v-icon
                small
                color="grey darken-1"
              >edit</v-icon>
            </v-btn>
            <span>Edit</span>
          </v-tooltip>

          <icon-img
            :item="selectedUser"
            color="primary lighten-1"
            size="32"
            caption
          />

          <v-subheader
            class="pl-2"
          >{{ $wrap.fullname(selectedUser) }}&nbsp;
            <add-me :id="selectedUser.id"/>
          </v-subheader>

        </v-layout>
      </template>
    </v-flex>
  </v-layout>

  <!-- remarks -->
  <v-layout row align-center class="mt-1">
    <v-flex
      hidden-xs-only
      sm3
    >
      <v-subheader>Remarks</v-subheader>
    </v-flex>
    <v-flex
      xs12
      sm9
    >
      <v-text-field
        label="Enter remarks"
        placeholder="Special instructions to include or any other remark"
        prepend-icon="subject"
        v-model="remarks"
        class="multi-line-textarea"
        multi-line
      />
    </v-flex>
  </v-layout>

  <!-- dialog course -->

  <v-dialog
    v-model="dialogCourse"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbarCourse"
      label="Search course"
      prepend-icon="search"
      :append-icon="searchCourse ? 'close' : undefined"
      :append-icon-cb="searchCourse ? () => { searchCourse = null } : undefined"
      v-model="searchCourse"
      :loading="loading"
    />

    <v-progress-linear
      :active="loading"
      :indeterminate="true"
      color="accent"
      class="my-0"
      :height="loading ? 3 : 0"
      background-color="white"
    />

    <select-list
      v-model="selectedCourseArr"
      :items="selectedCourseArr"
      id="selected-course-"
      max-height="25vh"
      align-center
      delete-mode
      editable
      :is-selected="(items, item) => JSON.stringify(items) == JSON.stringify(item)"
    >
      <template
        slot="title"
      >&nbsp;Selected</template>
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
        v-html="props.item.code"
      />
    </select-list>

    <select-list
      radio
      clearable
      v-model="selectedCourse"
      :items.sync="courses"
      id="courses-"
      max-height="25vh"
      :is-selected="(items, item) => JSON.stringify(items) == JSON.stringify(item)"
    >
      <template
        slot="title"
      ><strong
        v-text="courses.length"
      />&nbsp;{{ searchCourse ? 'Results' : 'Suggested' }}</template>
      <span
        slot="item"
        slot-scope="props"
        class="select-list-item"
        v-html="props.item.code"
      />
    </select-list>

  </v-dialog>

  
  <!-- dialog user -->

  <v-dialog
    v-model="dialogUser"
    width="640"
    transition="fade-transition"
  >
    <v-text-field
      solo
      ref="searchbarUser"
      label="Search user"
      prepend-icon="search"
      :append-icon="searchUser ? 'close' : undefined"
      :append-icon-cb="searchUser ? () => { searchUser = null } : undefined"
      v-model="searchUser"
      :loading="loading"
    />

    <v-progress-linear
      :active="loading"
      :indeterminate="true"
      color="accent"
      class="my-0"
      :height="loading ? 3 : 0"
      background-color="white"
    />

    <select-list
      v-model="selectedUserArr"
      :items="selectedUserArr"
      id="selected-user-"
      max-height="25vh"
      align-center
      delete-mode
      editable
      :is-selected="(items, item) => JSON.stringify(items) == JSON.stringify(item)"
    >
      <template
        slot="title"
      >&nbsp;Selected</template>
      <v-layout
        slot="item"
        slot-scope="props"
        align-center
      >
        <icon-img
          :item="props.item"
          color="primary lighten-1"
          size="32"
          caption
        />
        <div
          class="subheader pl-3"
        >{{ $wrap.fullname(props.item) }}&nbsp;
          <add-me :id="props.item.id"/>
        </div>
      </v-layout>
    </select-list>

    <select-list
      radio
      clearable
      v-model="selectedUser"
      :items.sync="users"
      id="users-"
      max-height="25vh"
      :is-selected="(items, item) => JSON.stringify(items) == JSON.stringify(item)"
    >
      <template
        slot="title"
      ><strong
        v-text="users.length"
      />&nbsp;{{ searchUser ? 'Results' : 'Suggested' }}</template>
      <v-layout
        slot="item"
        slot-scope="props"
        align-center
      >
        <span class="pl-2">
          <icon-img
            :item="props.item"
            color="primary lighten-1"
            size="32"
            caption
          />
        </span>
        <div
          class="subheader pl-3"
        >{{ $wrap.fullname(props.item) }}&nbsp;
          <add-me :id="props.item.id"/>
        </div>
      </v-layout>
    </select-list>

  </v-dialog>

</div>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'
import AddMe from '@/include/AddMe'
import IconImg from '@/include/IconImg'
import SelectList from '@/include/SelectList'

export default {
  name: 'workflow-info',
  components: {
    AddMe,
    IconImg,
    SelectList
  },
  props: {
    value: Object
  },
  data: () => ({
    userUrl: '/users/search',
    courseUrl: '/courses',
    item: null,
    levels: 0,
    remarks: null,

    dialogUser: false,
    dialogCourse: false,
    searchUser: null,
    searchCourse: null,
    loading: false,

    users: [],
    courses: [],

    selectedUser: null,
    selectedCourse: null,
    selectedUserArr: [],
    selectedCourseArr: []
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.item = e
      }
    },
    item: {
      deep: true,
      handler(e) {
        this.setInitial()
        this.$emit('input', e)
      }
    },

    selectedUser(e) {
      this.selectedUserArr = e ? [e] : []
      // set this in item
      this.item.assigned = e
    },
    selectedCourse(e) {
      this.selectedCourseArr = e ? [e] : []
      // set this in item
      this.item.course = e
    },
    selectedUserArr(e) {
      if (!e.length) {
        this.selectedUser = null
      }
    },
    selectedCourseArr(e) {
      if (!e.length) {
        this.selectedCourse = null
      }
    },
    levels(e) {
      if (!e || e < 1) {
        // this.levels = 1
        return
      }

      let currLevels = this.item.levels.length
      // if currLevels is greater than levels
      // delete levels
      // if currLevels is lesser than levels
      // add level
      // if equal, do nothing
      let itemLevel = this.item.levels
      if (currLevels > e) {
        itemLevel.splice(e, itemLevel.length-e)
      } else if (currLevels < e) {
        // 2...4
        // start from currLevels+1 until e
        let temp = e
        do {
          itemLevel.push({})
          temp--
        } while(temp > currLevels)
        // for (let i = currLevels+1; i <= e; i++) {
        //   itemLevel.push({})
        // }
      }
    },
    remarks(e) {
      this.item.remarks = e
    },

    dialogUser(e) {
      if (e) {
        this.suggestUsers()
        setTimeout(() => {
          this.$refs.searchbarUser.focus()
        })
      } else {
        this.searchUser = null
      }
    },
    searchUser(e) {
      this.loading = true
      this.queryUser()
    },

    dialogCourse(e) {
      if (e) {
        this.suggestCourses()
        setTimeout(() => {
          this.$refs.searchbarCourse.focus()
        })
      } else {
        this.searchCourse = null
      }
    },
    searchCourse(e) {
      this.loading = true
      this.queryCourse()
    }
  },
  created() {
    this.item = this.value
    this.setInitial()
  },

  methods: {
    setInitial() {
      this.remarks = this.item.remarks
      this.levels = this.item.levels.length
      this.selectedUser = this.item.assigned
      this.selectedCourse = this.item.course
    },

    queryUser: debounce(function(e) {
      // search for book if not empty
      const search = this.searchUser
      if (!search) {
        this.users = []
        this.suggestUsers()
        return
      }

      this.loading = true
      this.$http.post(this.userUrl, qs.stringify({
        search: search
      })).then((res) => {
        this.loading = false
        this.users = res.data.users
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    queryCourse: debounce(function(e) {
      // search for book if not empty
      const search = this.searchCourse
      if (!search) {
        this.courses = []
        this.suggestCourses()
        return
      }

      this.loading = true
      this.$http.post(this.courseUrl, qs.stringify({
        search: search
      })).then((res) => {
        this.loading = false
        this.courses = res.data.courses
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300),

    suggestUsers() {
      this.loading = false

    },
    suggestCourses() {
      this.loading = false

    }
  }
}
</script>
