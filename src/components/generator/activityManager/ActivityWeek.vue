<template>
<tr>
  <td>
    <button type="button" @click="$emit('remove', index)">x</button>
    <button type="button" @click="$emit('add', index + 1)">+</button>
  </td>
  <td>
    <input class="noOfWeeks" type="number" min="1" max="99" v-model="act.noOfWeeks">
  </td>
  <template v-if="cloLength">
    <td
      class="t-center"
      @mouseover="over(clo - 1, $event)"
      @mouseout="out(clo - 1, $event)"
      @click="click(clo - 1)"
      v-for="clo in cloLength"
      :key="clo">
      <template v-if="typeof act.cloMap !== 'undefined' && act.cloMap.indexOf(clo - 1) > -1"
        >x</template>
      <template v-else>&nbsp;</template>
    </td>
  </template>
  <td v-else>&nbsp;</td>
  <topic-picker
    :act="act"
    :index="index"
    :syllabus="syllabus"/>
  <tla
    :act="act"
    :index="index"
    :syllabus="syllabus"
    :type="3"/>
  <tla
    :act="act"
    :index="index"
    :syllabus="syllabus"
    :type="4"/>
  <instructional-materials
    :act="act"
    :index="index"
    :syllabus="syllabus"/>
  <assessment-tasks
    :act="act"
    :index="index"
    :syllabus="syllabus"/>
</tr>
</template>

<script>
import TopicPicker from './activityWeek/TopicPicker'
import Tla from './activityWeek/Tla'
import InstructionalMaterials from './activityWeek/InstructionalMaterials'
import AssessmentTasks from './activityWeek/AssessmentTasks'
import moveArray from '@/assets/js/moveArray'

export default {
  name: 'activity-week',
  components: {
    TopicPicker,
    Tla,
    InstructionalMaterials,
    AssessmentTasks
  },
  props: {
    act: Object,
    syllabus: Object,
    index: Number
  },

  computed: {
    cloLength() {
      return this.syllabus.content.courseLearningOutcomes.length
    }
  },

  watch: {
    act: {
      handler: function(to, from) {
        if (to !== null) {
          if (Number(to.noOfWeeks) <= 0) {
            this.act.noOfWeeks = 1
          } else if (Number(to.noOfWeeks) > 99) {
            this.act.noOfWeeks = 99
          }
        }
      },
      deep: true
    }
  },

  created() {
    this.$bus.$on('clo-updated', this.onCLOUpdated)
  },

  methods: {
    over(i, e) {
      e.target.classList.add('outcome-highlighted')
      this.$emit('highlighted', i)
    },
    out(i, e) {
      e.target.classList.remove('outcome-highlighted')
      this.$emit('highlighted', -1)
    },
    click(i) {
      if (typeof this.act.cloMap === 'undefined') {
        this.$set(this.act, 'cloMap', [])
      }

      let set = new Set(this.act.cloMap)
      // if existing, remove it
      set.has(i) ? set.delete(i) : set.add(i)
      this.act.cloMap = Array.from(set)

      // update topic suggestions
      this.$bus.$emit('update-suggestions')
    },

    onCLOUpdated(i, n) {
      this.act.cloMap = moveArray(this.act.cloMap, i, n)
    }
  }
}
</script>

<style scoped>
.noOfWeeks {
  width: 32px;
  margin: 0 auto;
  display: block;
}
</style>
