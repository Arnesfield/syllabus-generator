<template>
<div v-if="syllabus">

  <div class="pa-2">
    <v-list class="elevation-1 py-0" two-line>
      <v-list-tile
        ripple
        @click="add(activities.length)"
      >
        <v-list-tile-action class="thin-action">
          <v-tooltip top>
            <v-btn
              icon
              flat
              slot="activator"
              color="primary"
              @click="add(activities.length)"
            >
              <v-icon>today</v-icon>
            </v-btn>
            <span>Add activity</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title
            v-text="'Add activity'"
            class="primary--text text--lighten-1"
          />
          <v-list-tile-sub-title v-text="'Total activities: ' + activities.length"/>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </div>

  <v-divider class="mb-3 mt-2"/>

  <div class="scrollable-x elevation-1">
    <table class="syllabus-tbl no-outside-border">
      <tr>
        <th style="width: 1px">&nbsp;</th>
        <th style="width: 1px">Weeks</th>
        <th>Intended Learning Outcomes (ILO)</th>
        <th>Detailed Course Content</th>
        <th colspan="2">Teaching Activities and Learning Outcomes</th>
        <th>Instructional Materials</th>
        <th>Assessment Tasks (AT)</th>
        <th>CLO</th>
      </tr>
      <tr>
        <td>
          <div style="margin: 0 auto; width: 32px">
            <v-tooltip top>
              <v-btn
                icon
                small
                flat
                class="ma-0"
                slot="activator"
                @click="add(0)"
              >
                <v-icon small color="grey darken-1">add</v-icon>
              </v-btn>
              <span>Add</span>
            </v-tooltip>
          </div>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td class="text-xs-center">Faculty</td>
        <td class="text-xs-center">Students</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <activity-week
        :key="index"
        :index="index"
        :act="activity"
        :syllabus="syllabus"
        v-for="(activity, index) in activities"
        @add="add"
        @remove="remove"/>
      <tr>
        <td>&nbsp;</td>
        <td class="text-xs-center">Total Week/s: {{ totalWeeks }}</td>
        <td :colspan="cloLength + 7">&nbsp;</td>
      </tr>
    </table>
  </div>

</div>
</template>

<script>
import ActivityWeek from './activityManager/ActivityWeek'

export default {
  name: 'activity-manager',
  components: {
    ActivityWeek
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    activities: []
  }),

  computed: {
    cloLength() {
      return this.syllabus.content.courseLearningOutcomes.length
    },
    totalWeeks() {
      return this.activities.reduce((total, act) => {
        return total + Number(act.noOfWeeks)
      }, 0)
    }
  },

  watch: {
    syllabus(to, from) {
      if (to !== null) {
        this._setInitial()
      }
    },

    activities(to, from) {
      // set to syllabus
      this.syllabus.content.weeklyActivities = to
    }
  },

  created() {
    if (this.syllabus !== null) {
      this._setInitial()
    }
  },

  methods: {
    add(i) {
      this.activities.splice(i, 0, {
        noOfWeeks: 1,
        topics: [],
        ilo: [],
        cloMap: [],
        tlaFaculty: [],
        tlaStudent: [],
        instructionalMaterials: [],
        assessmentTasks: []
      })
    },
    remove(i) {
      this.activities.splice(i, 1)
    },

    _setInitial() {
      if (typeof this.syllabus.content.weeklyActivities === 'undefined') {
        this.$set(this.syllabus.content, 'weeklyActivities', this.activities)
      } else {
        this.activities = this.syllabus.content.weeklyActivities
      }
    },
  }
}
</script>
