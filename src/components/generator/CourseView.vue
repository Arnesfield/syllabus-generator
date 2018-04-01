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

      <!-- two-line -->
      <v-list
        two-line
        @click="() => {}"
        class="elevation-1 py-0 mb-3"
      >
        <v-list-tile>
          <v-list-tile-action class="thin-action">
            <v-icon color="primary lighten-1">description</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title
              v-text="'Course Description'"
              class="primary--text text--lighten-1"
            />
            <v-list-tile-sub-title v-text="'Description of the course'"/>
          </v-list-tile-content>
        </v-list-tile>

        <v-divider/>

        <v-layout
          align-center
          class="px-2 py-3 ml-1 mr-3"
        >
          <markdown-textarea
            edit-on-click
            v-model="course.description"
            t-add-class="my-medium-textarea pa-2"
          />
        </v-layout>
      </v-list>

      <!-- objectives -->
      <v-subheader class="mt-2">Objectives</v-subheader>

      <!-- two-line -->
      <v-list
        two-line
        @click="() => {}"
        class="elevation-1 py-0 mb-3"
      >
        <v-list-tile>
          <v-list-tile-action class="thin-action">
            <v-icon color="primary lighten-1">done_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title
              v-text="'Course Objectives'"
              class="primary--text text--lighten-1"
            />
            <v-list-tile-sub-title v-text="'Objectives of the course'"/>
          </v-list-tile-content>
        </v-list-tile>

        <v-divider/>

        <v-layout
          align-center
          class="px-2 py-3 ml-1 mr-3"
        >
          <markdown-textarea
            edit-on-click
            v-model="course.objectives"
            t-add-class="my-medium-textarea pa-2"
          />
        </v-layout>
      </v-list>

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
</v-container>
</template>

<script>
import CourseUnits from '@/include/CourseUnits'
import MarkdownTextarea from '@/include/MarkdownTextarea'
import RelatedCourseList from '@/include/RelatedCourseList'

export default {
  name: 'course-view',
  components: {
    CourseUnits,
    MarkdownTextarea,
    RelatedCourseList
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
  }
}
</script>
