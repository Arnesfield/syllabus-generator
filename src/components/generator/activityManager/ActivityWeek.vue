<template>
<tr>
  <td style="width: 1px; margin: 0 auto">
    <div style="margin: 0 auto; width: 32px">
      <v-tooltip top>
        <v-btn
          icon
          small
          flat
          class="ma-0"
          slot="activator"
          @click="$emit('remove', index)"
        >
          <v-icon small color="error">close</v-icon>
        </v-btn>
        <span>Remove</span>
      </v-tooltip>
      <v-tooltip top>
        <v-btn
          icon
          small
          flat
          class="ma-0"
          slot="activator"
          @click="$emit('add', index + 1)"
        >
          <v-icon small color="grey darken-1">add</v-icon>
        </v-btn>
        <span>Add Below</span>
      </v-tooltip>
    </div>
  </td>
  <td>
    <input class="noOfWeeks" type="number" min="1" max="99" v-model="act.noOfWeeks">
  </td>
  <td style="width: 1px">
    <ilo-picker
      :act="act"
      :index="index"
      :syllabus="syllabus"
      v-model="act.ilo"
    />
  </td>
  <td style="width: 1px">
    <topic-picker
      :act="act"
      :index="index"
      :syllabus="syllabus"
      v-model="act.topics"
    />
  </td>
  <td style="width: 1px">
    <tla
      :act="act"
      :index="index"
      :syllabus="syllabus"
      :type="3"
      v-model="act.tlaFaculty"
    />
  </td>
  <td style="width: 1px">
    <tla
      :act="act"
      :index="index"
      :syllabus="syllabus"
      :type="4"
      v-model="act.tlaStudent"
    />
  </td>
  <td style="width: 1px">
    <instructional-materials
      :act="act"
      :index="index"
      :syllabus="syllabus"
      v-model="act.instructionalMaterials"
    />
  </td>
  <td style="width: 1px">
    <assessment-tasks
      :act="act"
      :index="index"
      :syllabus="syllabus"
      v-model="act.assessmentTasks"
    />
  </td>
  <td style="width: 1px">
    <v-select
      :items="cloNumbers"
      v-model="act.cloMap"
      dense
      multiple>
      <template
        slot="selection"
        slot-scope="data"
      >{{ Number(data.item) + 1 + (data.index != data.parent.value.length - 1 ? ', ' : '') }}</template>
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
      this.$bus.$emit('gen--suggestions.update', this.index)
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
