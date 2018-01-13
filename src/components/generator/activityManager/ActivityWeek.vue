<template>
<tr>
  <td>
    <button type="button" @click="$emit('remove', index)">x</button>
    <button type="button" @click="$emit('add', index + 1)">+</button>
  </td>
  <td>
    <input class="noOfWeeks" type="number" min="1" max="99" v-model="act.noOfWeeks">
  </td>
  <template v-if="iloLength">
    <td
      class="t-center"
      @mouseover="over(ilo - 1, $event)"
      @mouseout="out(ilo - 1, $event)"
      @click="click(ilo - 1)"
      v-for="ilo in iloLength"
      :key="ilo">
      <template v-if="typeof act.iloMap !== 'undefined' && act.iloMap.indexOf(ilo - 1) > -1"
        >x</template>
      <template v-else>&nbsp;</template>
    </td>
  </template>
  <td v-else>&nbsp;</td>
  <topic-picker
    :act="act"
    :index="index"
    :bus="weekBus"
    :syllabus="syllabus"/>
  <tla
    :act="act"
    :index="index"
    :bus="weekBus"
    :syllabus="syllabus"
    :type="3"/>
  <tla
    :act="act"
    :index="index"
    :bus="weekBus"
    :syllabus="syllabus"
    :type="4"/>
  <instructional-materials
    :act="act"
    :index="index"
    :bus="weekBus"
    :syllabus="syllabus"/>
</tr>
</template>

<script>
import Vue from 'vue'
import TopicPicker from './activityWeek/TopicPicker'
import Tla from './activityWeek/Tla'
import InstructionalMaterials from './activityWeek/InstructionalMaterials'
import moveArray from '@/assets/js/moveArray'

export default {
  name: 'activity-week',
  components: {
    TopicPicker,
    Tla,
    InstructionalMaterials
  },
  props: {
    act: Object,
    syllabus: Object,
    bus: Object,
    index: Number
  },
  data: () => ({
    weekBus: new Vue()
  }),

  computed: {
    iloLength() {
      return this.syllabus.content.intendedLearningOutcomes.length
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
    if (this.bus !== null) {
      this.bus.$on('ilo-updated', this.onILOUpdated)
    }
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
      if (typeof this.act.iloMap === 'undefined') {
        this.$set(this.act, 'iloMap', [])
      }

      let set = new Set(this.act.iloMap)
      // if existing, remove it
      set.has(i) ? set.delete(i) : set.add(i)
      this.act.iloMap = Array.from(set)

      // update topic suggestions
      this.weekBus.$emit('update-suggestions')
    },

    onILOUpdated(i, n) {
      this.act.iloMap = moveArray(this.act.iloMap, i, n)
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
