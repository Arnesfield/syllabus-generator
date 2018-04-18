<template>
<v-dialog
  v-model="show"
  width="800"
  :persistent="loading || id.length > 1"
  transition="fade-transition"
  scrollable
>
  <v-card v-if="show" style="overflow-x: hidden">

    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      class="ma-0"
    />

    <v-toolbar
      card
      dark
      color="primary lighten-1"
      v-if="item"
    >
      <!-- extended -->
      <v-btn
        icon
        @click="goBack"
      >
        <v-icon>arrow_back</v-icon>
      </v-btn>

      <v-layout
        class="minimal-scrollbar"
        style="position: relative; height: inherit; width: calc(100% - 156px); overflow-x: auto"
        align-center
      >
        <v-breadcrumbs
          v-if="code.length"
          class="py-0 pl-0"
          style="position: absolute; width: max-content;"
        >
          <v-icon slot="divider">chevron_right</v-icon>
          <v-breadcrumbs-item
            :key="i"
            v-for="(c, i) in code"
            @click.native="selectBreadcrumb(i)"
            @keypress.enter="selectBreadcrumb(i)"
          >
            <span
              v-text="c"
              :class="{ 'white--text': i != code.length-1 }"
            />
          </v-breadcrumbs-item>
        </v-breadcrumbs>
      </v-layout>

      <v-spacer/>

      <v-btn
        icon
        @click="show = false"
      >
        <v-icon>close</v-icon>
      </v-btn>

      <!-- menu -->
      <v-menu
        left
        offset-y
        v-if="item"
      >
        <v-btn
          icon
          slot="activator"
        >
          <v-icon>more_vert</v-icon>
        </v-btn>
        <v-list>
          <v-list-tile
            ripple
            :key="i"
            v-for="(m, i) in menu"
            :to="m.to"
          >
            <v-list-tile-action>
              <v-icon>{{ m.icon }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-content v-text="m.text"/>
          </v-list-tile>
        </v-list>
      </v-menu>
    </v-toolbar>

    <v-card-title
      v-if="item"
      class="pt-3 pb-0"
    >
      <div>
        <div class="headline">{{ item.code }}</div>
        <div class="subheading">{{ item.title }}</div>
      </div>
    </v-card-title>

    <v-divider
      class="my-2"
      v-if="item"
    />

    <v-card-text
      class="pt-0"
      :class="{ 'pb-0': !Boolean(item) }"
    >

      <v-layout row wrap v-if="item">
        <v-flex
          xs12
          sm7
          class="px-1"
        >
          
          <!-- units -->
          <div>
            <simple-small-header-text
              class="mb-1"
              text="Units / Type"
              icon="format_list_numbered"
            />
            <div>
              <course-units :course="item"/>
            </div>
          </div>
          
          <!-- description -->
          <div
            class="mt-3"
            v-if="item.description && item.description.length"
          >
            <simple-small-header-text
              class="my-1"
              text="Description"
              icon="description"
            />
            <div
              class="my-list"
              v-html="$md.makeHtml(item.description)"
            />
          </div>
          
          <!-- objectives -->
          <div
            class="mt-3"
            v-if="item.objectives && item.objectives.length"
          >
            <simple-small-header-text
              class="my-1"
              text="Objectives"
              icon="done_all"
            />
            <div
              class="my-list"
              v-html="$md.makeHtml(item.objectives)"
            />
          </div>

          <!-- prerequisites -->
          <div
            v-if="item.prerequisites && item.prerequisites.length"
            class="mt-3"
          >
            <simple-small-header-text
              class="my-1"
              text="Prerequisites"
              icon="school"
            />
            <related-course-chips
              :courses="item.prerequisites"
              @select="selectCourse"
            />
          </div>

          <!-- corequisites -->
          <div
            v-if="item.corequisites && item.corequisites.length"
            class="mt-3"
          >
            <simple-small-header-text
              class="my-1"
              text="Corequisites"
              icon="school"
            />
            <related-course-chips
              :courses="item.corequisites"
              @select="selectCourse"
            />
          </div>

          <!-- tags -->
          <div
            v-if="item.tags && item.tags.length"
            class="mt-3"
          >
            <simple-small-header-text
              class="my-1"
              text="Related tags"
              icon="label"
            />
            <div>
              <v-chip
                :key="i"
                v-for="(tag, i) in item.tags"
              >{{ tag }}</v-chip>
            </div>
          </div>

        </v-flex>

        <v-flex
          xs12
          sm5
          class="px-1"
        >
          <div class="hidden-sm-and-up my-2"/>
          <simple-small-header-text
            class="my-1"
            text="Syllabi"
            icon="assignment"
          />
          <div v-if="item.syllabi.length">
            <v-list
              dense
              two-line
              class="elevation-1 py-0"
            >
              <template v-for="(s, i) in item.syllabi">
                <v-list-tile
                  ripple
                  @click="selectSyllabus(item.id, s.id)"
                  :key="'tile-' + i"
                >
                  <v-list-tile-content>
                    <v-list-tile-title
                      v-text="'v' + s.version"
                    />
                    <v-list-tile-sub-title
                      v-text="$moment.unix(s.updated_at).format('MM/DD/YY h:mmA')"
                    />
                  </v-list-tile-content>
                </v-list-tile>

                <v-divider
                  :key="'divider-' + i"
                  v-if="i != item.syllabi.length-1"
                />
              </template>
            </v-list>
          </div>
          <div
            v-else
            class="caption grey--text pa-2 text-xs-center"
            v-text="'No syllabi :('"
          />
        </v-flex>
      </v-layout>

      <manage-no-data
        v-else
        class="py-3"
        :fetch="() => { fetch() }"
        :loading="loading"
        msg="Unable to load course :("
      >
        <v-btn
          slot="btn"
          color="primary lighten-1"
          @click="show = false"
        >Close</v-btn>
      </manage-no-data>

    </v-card-text>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import CourseUnits from '@/include/CourseUnits'
import ManageNoData from '@/include/ManageNoData'
import RelatedCourseChips from '@/include/RelatedCourseChips'
import SimpleSmallHeaderText from '@/include/SimpleSmallHeaderText'

export default {
  name: 'dialog-detailed-course',
  components: {
    CourseUnits,
    ManageNoData,
    RelatedCourseChips,
    SimpleSmallHeaderText
  },
  data: () => ({
    url: '/courses',
    id: [],
    code: [],
    item: null,
    show: false,
    loading: false
  }),

  computed: {
    menu() {
      let id = this.item.id
      return [
        { icon: 'trending_down', text: 'View course tree', to: '/tree/' + id },
        { icon: 'trending_up', text: 'View reverse course tree', to: '/tree/reverse/' + id }
      ]
    }
  },

  watch: {
    show(e) {
      // if unshow
      if (!e) {
        this.clear()
      }
    },
    id(e) {
      // clear item for loading
      this.item = null
      // get last value in e
      if (!e.length) {
        return
      }
      this.fetch(e[e.length-1])
    }
  },

  methods: {
    viewItem(id) {
      this.id = [id]
      this.code = []
      this.item = null
      this.show = true
    },

    fetch(id) {
      if (typeof id === 'undefined') {
        if (!this.id.length) {
          return
        }
        id = this.id[this.id.length-1]
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        cid: id,
        withRelated: true,
        withSyllabi: true
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        if (res.data.courses.length) {
          this.item = res.data.courses[0]
          // get index of id
          this.code[this.id.indexOf(id)] = this.item.code
        }
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    },

    goBack() {
      this.id.splice(this.id.length-1, 1)
      this.code.splice(this.code.length-1, 2)
      if (!this.id.length) {
        this.show = false
        return
      }
    },
    selectSyllabus(cid, sid) {
      this.show = false
      this.$router.push('/syllabus/view/' + cid + '/' +  sid)
    },
    selectCourse(id, code) {
      // push id and code
      this.id.push(id)
      this.code.push(code)
    },
    selectBreadcrumb(i) {
      // remove all i+1 and above
      // first, get length of id
      // assume 4, i 1
      // 1 2 3 4
      // disregard if i is the last index
      if (i == this.code.length-1) {
        return
      }
      this.id.splice(i+1, this.id.length - (i+1))
      this.code.splice(i+1, this.code.length - (i+1))
    },

    clear() {
      this.id = []
      this.code = []
      this.item = null
      this.loading = false
    }
  }
}
</script>
