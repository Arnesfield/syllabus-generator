<template>
<tr>
  <td>
    <button type="button" @click="$emit('remove', index)" class="red--text">&times;</button>
    <button type="button" @click="$emit('add', index + 1)">+</button>
  </td>
  <td>
    <input class="noOfWeeks" type="number" min="1" max="99" v-model="act.noOfWeeks">
  </td>
  <ilo-picker
    :act="act"
    :index="index"
    :syllabus="syllabus"/>
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
  <td>
    <v-select
      :items="cloNumbers"
      v-model="act.cloMap"
      dense
      multiple>
      <template slot="selection" slot-scope="data"
        >{{ (Number(data.item) + 1) + (data.index < data.parent.value.length - 1 ? ', ' : '') }}</template>
      <template slot="item" slot-scope="data">
        <v-list-tile-content>
          <v-list-tile-title>{{ (Number(data.item) + 1) + '. ' + (clos[data.item] ? clos[data.item] : '') }}</v-list-tile-title>
        </v-list-tile-content>
      </template>
    </v-select>
  </td>
</tr>
</template>

<script>
import TopicPicker from './activityWeek/TopicPicker'
import Tla from './activityWeek/Tla'
import InstructionalMaterials from './activityWeek/InstructionalMaterials'
import AssessmentTasks from './activityWeek/AssessmentTasks'
import IloPicker from './activityWeek/IloPicker'
import moveArray from '@/assets/js/moveArray'

export default {
  name: 'activity-week',
  components: {
    TopicPicker,
    Tla,
    InstructionalMaterials,
    AssessmentTasks,
    IloPicker
  },
  props: {
    act: Object,
    syllabus: Object,
    index: Number
  },

  computed: {
    cloLength() {
      return this.syllabus.content.courseLearningOutcomes.length
    },
    cloNumbers() {
      return this.syllabus.content.courseLearningOutcomes.map((e, i) => i)
    },
    clos() {
      return this.syllabus.content.courseLearningOutcomes
    }
  },

  watch: {
    act: {
      deep: true,
      handler: function(to, from) {
        if (to !== null) {
          if (Number(to.noOfWeeks) <= 0) {
            this.act.noOfWeeks = 1
          } else if (Number(to.noOfWeeks) > 99) {
            this.act.noOfWeeks = 99
          }
        }
      }
    },

    'act.cloMap': function(to, from) {
      // update topic suggestions when map changes
      this.$bus.$emit('gen--suggestions.update')
    }
  },

  created() {
    this.$bus.$on('gen--clo.updated', this.onCLOUpdated)
  },
  beforeDestroy() {
    this.$bus.$off('gen--clo.updated', this.onCLOUpdated)
  },

  methods: {
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
