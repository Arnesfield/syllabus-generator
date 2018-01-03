<template>
<div v-if="weeks">

  <h4>Weekly Activities</h4>
  <div>
    <span>Number of weeks</span>
    <input type="number" v-model="totalWeeks">
  </div>

  <br>

  <table border="1">
    <tr>
      <th>&nbsp;</th>
      <th>Week</th>
      <th v-if="syllabus.content.intendedLearningOutcomes.length"
        :colspan="syllabus.content.intendedLearningOutcomes.length">Intended Learning Outcome (ILO)</th>
      <th>Detailed Course Content</th>
    </tr>
    <tr>
      <td>
        <button @click="addAct(0)">+</button>
      </td>
      <td>&nbsp;</td>
      <td :key="ilo.label" v-for="ilo in syllabus.content.intendedLearningOutcomes"
        style="text-align: center">{{ ilo.label }}</td>
      <td>&nbsp;</td>
    </tr>
    <activity-week
      :ref="'aw-' + index"
      :key="week"
      v-for="(week, index) in weeks"
      :week="week"
      :weeks="weeks"
      :index="index"
      :totalWeeks="totalWeeks"
      :syllabus="syllabus"
      @add="addAct"
      @remove="removeAct"
      @change-until="updateWeeks"
      @over="boxOver"
      @out="boxOut"/>
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
    boxOver(label) {
      this.$emit('over', label)
    },
    boxOut(label) {
      this.$emit('out', label)
    },
    iloAdd(index) {
      // move ilo with index
      this.weeks.forEach((e, i) => {
        let ilo = e.intendedLearningOutcomes
        let updated = ilo.map(c => {
          let num = Number(c)
          // if ilo (num) is greater
          return num > index ? String(num + 1) : String(c)
        })
        this.weeks[i].intendedLearningOutcomes = updated
      })
    },
    iloRemove(index) {
      this.weeks.forEach((e, i) => {
        let ilo = e.intendedLearningOutcomes
        let updated = ilo.reduce((filtered, c) => {
          let num = Number(c)
          if (num > index + 1) {
            if (num - 1 !== -1) {
              filtered.push(String(num - 1))
            }
          } else if (num !== index + 1) {
            filtered.push(c)
          }
          return filtered
        }, [])
        this.weeks[i].intendedLearningOutcomes = updated
      })
    },

    addAct(i) {
      this.weeks.splice(i, 0, {
        from: null,
        until: null,
        intendedLearningOutcomes: []
      })
      this.updateWeeks()
    },
    removeAct(i) {
      this.weeks.splice(i, 1)
      this.updateWeeks()
    },

    updateWeeks() {

      // traverse weeks and change week values
      let length = this.weeks.length

      for (let i = 0; i < length; i++) {
        let week = this.weeks[i]
        let weekAfter = i < length-1 ? this.weeks[i+1] : null

        if (i === 0) {
          week.from = 1
        }

        if (weekAfter !== null) {
          weekAfter.from = week.until !== null ? week.until + 1 : null
        }

        if (week.from > week.until) {
          week.from = null
        }

        if (i === length-1) {
          week.until = this.totalWeeks
        }
        
      }

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
