<template>
<div v-if="syllabus">

  <h4 class="headline mb-2">Weekly Activities</h4>

  <suggest-alert/>
  <div class="scrollable-x">
    <table class="syllabus-tbl" border="1">
      <tr>
        <th style="width: 1px">&nbsp;</th>
        <th style="width: 1px">Weeks</th>
        <th>CLO</th>
        <th>Detailed Course Content</th>
        <th colspan="2">Teaching Activities and Learning Outcomes</th>
        <th>Instructional Materials</th>
        <th>Assessment Tasks (AT)</th>
      </tr>
      <tr>
        <td>
          <button type="button" @click="add(0)">+</button>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td class="text-xs-center">Faculty</td>
        <td class="text-xs-center">Students</td>
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
        <td :colspan="cloLength + 6">&nbsp;</td>
      </tr>
    </table>
  </div>

</div>
</template>

<script>
import ActivityWeek from './activityManager/ActivityWeek'
import SuggestAlert from '@/include/generator/SuggestAlert'

export default {
  name: 'activity-manager',
  components: {
    ActivityWeek,
    SuggestAlert
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
      }
    },
  }
}
</script>
