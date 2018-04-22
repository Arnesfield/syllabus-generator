<template>
<v-navigation-drawer
  app
  fixed
  :mini-variant="false"
  :clipped="true"
  width="380"
  v-model="$bus.toolbar.course.model"
  right
  style="padding-bottom: 0"
>

  <v-toolbar
    flat
    dark
    :tabs="course !== null"
    color="accent"
  >
    <v-toolbar-title v-html="title"/>
    <v-spacer/>
    <btn-refresh tip="bottom"/>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.toolbar.course.model = false"
      >
        <v-icon>chevron_right</v-icon>
      </v-btn>
      <span>Hide</span>
    </v-tooltip>

    <v-tabs
      show-arrows
      v-model="tabs"
      slot="extension"
      v-if="course !== null"
      color="accent"
      slider-color="primary lighten-1"
    >
      <v-tab
        :key="item"
        :disabled="loading"
        v-for="item in tabItems"
      >{{ item }}</v-tab>
    </v-tabs>
  </v-toolbar>

  <v-tabs-items
    v-model="tabs"
    v-if="course !== null"
  >

    <!-- info -->

    <v-tab-item>
      <v-container fluid>
        <detailed-course-info
          :item="course"
          @select="selectCourse"
        />
      </v-container>
    </v-tab-item>

    <!-- syllabi -->

    <v-tab-item>
      <div v-if="course.syllabi.length" class="pb-2">
        <v-list
          dense
          two-line
          class="elevation-1 py-0"
        >
          <template v-for="(s, i) in course.syllabi">
            <v-list-tile
              ripple
              @click="selectSyllabus(course.id, s.id)"
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
              v-if="i != course.syllabi.length-1"
            />
          </template>
        </v-list>
      </div>
      <v-container
        fluid
        v-else
        class="caption grey--text text-xs-center"
        v-text="'No syllabi :('"
      />
    </v-tab-item>

  </v-tabs-items>

  <v-container
    fluid
    v-else
  >
    <v-layout justify-center>
      <manage-no-data
        :fetch="fetch"
        :loading="loading"
        msg="Unable to load course information :("
      />
    </v-layout>
  </v-container>

</v-navigation-drawer>
</template>

<script>
import qs from 'qs'
import BtnRefresh from '@/include/BtnRefresh'
import ManageNoData from '@/include/ManageNoData'
import DetailedCourseInfo from '@/include/DetailedCourseInfo'

export default {
  name: 'sidenav-course',
  components: {
    BtnRefresh,
    ManageNoData,
    DetailedCourseInfo
  },
  props: {
    courseId: [Number, String]
  },
  data: () => ({
    url: '/courses',
    course: null,
    loading: false,
    cid: null,

    tabs: 0,
    tabItems: ['info', 'syllabi']
  }),
  watch: {
    courseId(e) {
      this.cid = e
    },
    cid(e) {
      this.$emit('update:courseId', e)
      this.course = null
      this.fetch()
    },
    loading(e) {
      this.$bus.refresh(e)
    }
  },
  computed: {
    title() {
      return this.course ? this.course.code : 'Course'
    }
  },

  created() {
    this.$bus.$on('refresh--btn', this.fetch)
    this.cid = this.courseId
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
  },

  methods: {
    selectCourse(id, code) {
      this.cid = id
    },

    selectSyllabus(cid, sid) {
      this.$router.push('/syllabus/view/' + cid + '/' +  sid)
    },

    fetch() {
      let id = this.cid
      if (typeof id === 'undefined' || typeof id === 'object') {
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        cid: id,
        deep: true,
        withRelated: true,
        withSyllabi: true,
        formatSyllabi: true
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        if (res.data.courses.length) {
          this.course = res.data.courses[0]
        }
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
