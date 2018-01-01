<template>
<div v-if="weeks">
  <div>
    <span>Number of weeks</span>
    <input type="number" v-model="totalWeeks">
  </div>

  <activity-week
    :ref="'aw-' + index"
    :key="week"
    v-for="(week, index) in weeks"
    :week="week"
    :weeks="weeks"
    :index="index"
    :totalWeeks="totalWeeks"
    @change-until="updateWeeks"/>

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
    syllabus: Object,
  },
  data: () => ({
    // by default
    totalWeeks: 15,
    weeks: null,
    acts: null
  }),

  watch: {
    syllabus(to, from) {
      if (to !== null && to !== from) {
        this._updateData()
      }
    },
    totalWeeks(to, from) {
      if (to < 1) {
        this.totalWeeks = from
        return
      }
      this.updateWeeks()
    }
  },

  created() {
    this._updateData()
  },

  methods: {
    updateWeeks(allowInsert) {
      allowInsert = typeof allowInsert === 'boolean' ? allowInsert : false

      if (!this.weeks.length) {
        this.weeks.push({
          from: 1,
          until: this.totalWeeks,
        })
      }

      // traverse weeks backwards and see if until is less than totalWeeks left
      let totalWeeksLeft = this.totalWeeks
      let length = this.weeks.length - 1
      for (let i = length; i >= 0; i--) {
        let week = this.weeks[i]
        // if less than
        // only insert if allowed
        if (allowInsert && week.until < totalWeeksLeft) {
          this.weeks.splice(i + 1, 0, {
            from: week.until + 1,
            until: totalWeeksLeft
          })
        }
        // else
        // attempt 1: else if (week.until > totalWeeksLeft)
        else {
          // change values
          week.until = totalWeeksLeft
          // if from is greater than until
          if (week.from > week.until) {
            week.from = totalWeeksLeft
          }
        }

        totalWeeksLeft = week.from - 1
      }

      return this.weeks
    },

    _updateData() {
      this.acts = this.syllabus.content.weeklyActivities
      this.totalWeeks = this.acts.totalWeeks
      this.weeks = this.acts.weeks
      this.updateWeeks()
    }
  }
}
</script>
