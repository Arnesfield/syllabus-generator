<template>
<div v-if="syllabus">

  <h4>Weekly Activities</h4>

  <table class="w-max collapsed" border="1">
    <tr>
      <th style="width: 1px">&nbsp;</th>
      <th style="width: 1px">Weeks</th>
      <th style="width: 1px"
        :colspan="iloLength">Intended Learning Outcomes (ILO)</th>
      <th>Topics</th>
      <th colspan="2">Teaching Activities and Learning Outcomes</th>
      <th>Assessment Tasks (AT)</th>
    </tr>
    <tr>
      <td>
        <button type="button" @click="add(0)">+</button>
      </td>
      <td>&nbsp;</td>
      <template v-if="iloLength">
        <td
          class="t-center"
          v-for="ilo in iloLength"
          :key="ilo">{{ ilo }}</td>
      </template>
      <td v-else>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="t-center">Faculty</td>
      <td class="t-center">Students</td>
      <td>&nbsp;</td>
    </tr>
    <activity-week
      :key="index"
      :index="index"
      :act="activity"
      :syllabus="syllabus"
      :bus="bus"
      v-for="(activity, index) in activities"
      @add="add"
      @remove="remove"
      @highlighted="setHighlighted"/>
    <tr>
      <td>&nbsp;</td>
      <td class="t-center">Total Week/s: {{ totalWeeks }}</td>
      <td :colspan="iloLength + 5">
        <template v-if="highlighted.length">
          <strong>Highlighted:</strong> {{ highlighted }}
        </template>
        <template v-else>&nbsp;</template>
      </td>
    </tr>
  </table>
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
    bus: Object,
    syllabus: Object
  },
  data: () => ({
    activities: [],
    highlighted: ''
  }),

  computed: {
    iloLength() {
      return this.syllabus.content.intendedLearningOutcomes.length
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
        iloMap: []
      })
    },
    remove(i) {
      this.activities.splice(i, 1)
    },

    setHighlighted(i) {
      this.highlighted = i === -1 ? '' : this.syllabus.content.intendedLearningOutcomes[i].content
    },

    _setInitial() {
      if (typeof this.syllabus.content.weeklyActivities === 'undefined') {
        this.$set(this.syllabus.content, 'weeklyActivities', this.activities)
      }
    },
  }
}
</script>
