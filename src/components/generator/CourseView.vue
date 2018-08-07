<template>
<v-container fluid grid-list-lg class="pa-0">
  <v-layout row wrap>
    <v-flex xs12 sm6>
      <v-subheader>Course Information</v-subheader>

      <v-list
        two-line
        class="elevation-1 py-0"
      >

        <!-- title and code -->

        <v-list-tile @click="() => {}">
          <v-list-tile-action class="thin-action">
            <v-icon color="primary lighten-1">school</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title
              v-text="course.code"
              class="primary--text text--lighten-1"
            />
            <v-list-tile-sub-title v-text="course.title"/>
          </v-list-tile-content>
        </v-list-tile>

        <v-divider/>

        <!-- units -->

        <v-list-tile @click="() => {}">
          <v-list-tile-action class="thin-action">
            <v-icon>format_list_numbered</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>
              <course-units :course="course"/>
            </v-list-tile-title>
            <v-list-tile-sub-title v-text="'Units / Type'"/>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>

      <!-- description and objectives -->
      <v-subheader class="mt-2">Description and objectives</v-subheader>
      <simple-list-content-view
        v-model="course.description"
        auto-edit-mode
        class="mb-3"
        icon="description"
        title="Course Description"
        subtitle="Description of the course"
        placeholder="Enter Course Description"
      />

      <!-- objectives -->
      <v-subheader class="mt-2">Objectives</v-subheader>
      <simple-list-content-view
        v-model="course.objectives"
        auto-edit-mode
        class="mb-3"
        icon="done_all"
        title="Course Objectives"
        subtitle="Objectives of the course"
        placeholder="Enter Course Objectives"
      />

    </v-flex>

    <!-- related -->

    <v-flex xs12 sm6>
      
      <div>
        <v-subheader
          v-if="course.prerequisites"
        >Prerequisites</v-subheader>

        <related-course-list
          header
          :items="course.prerequisites"
          title="Prerequisite"
          subtitle="prerequisites"
          @select="viewItem"
        />

        <v-subheader
          class="mt-2"
          v-if="course.prerequisites"
        >Corequisites</v-subheader>

        <related-course-list
          header
          :items="course.corequisites"
          title="Corequisite"
          subtitle="corequisites"
          @select="viewItem"
        />
      </div>

      <!-- next button -->
      
      <!-- <v-layout class="mt-4">
        <v-spacer/>
        <v-btn
          large
          color="primary lighten-1"
          @click="$bus.tabs.Generator.tab = '1'"
        >
          <span>Syllabus</span>
          <v-icon>navigate_next</v-icon>
        </v-btn>
      </v-layout> -->

    </v-flex>

  </v-layout>

  <dialog-detailed-course ref="dialog"/>

</v-container>
</template>

<script>
import CourseUnits from '@/include/CourseUnits'
import RelatedCourseList from '@/include/RelatedCourseList'
import SimpleListContentView from '@/include/SimpleListContentView'
import DialogDetailedCourse from '@/include/dialogs/DialogDetailedCourse'

export default {
  name: 'course-view',
  components: {
    CourseUnits,
    RelatedCourseList,
    SimpleListContentView,
    DialogDetailedCourse
  },
  props: {
    value: Object
  },
  data: () => ({
    course: null
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.course = e
      }
    },
    course: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
      }
    }
  },

  created() {
    this.course = this.value
  },

  methods: {
    viewItem(id) {
      if (this.$refs.dialog) {
        this.$refs.dialog.viewItem(id)
      }
    }
  }
}
</script>
