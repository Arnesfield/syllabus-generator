<template>
<tr>
  <td>
    <button @click="$emit('remove', index)">x</button>
    <button @click="$emit('add', index + 1)">+</button>
  </td>

  <td>

    <div>From: {{ week.from }}</div>
    <div>
      Until:
      <template v-if="index < weeks.length - 1">
        <select v-model="week.until" @change="onChangeUntil">
          <option :value="n" v-for="n in Number(totalWeeks)-1" :key="n">{{ n }}</option>
        </select>
      </template>
      <template v-else>
        {{ week.until }}
      </template>
    </div>

  </td>

  <td
    @mouseover="boxOver(index, ilo.label)"
    @mouseout="boxOut(index, ilo.label)"
    @click="boxClick(index, ilo.label)"
    :ref="'box-' + index + '-' + ilo.label"
    :key="ilo.label"
    v-for="ilo in syllabus.content.intendedLearningOutcomes"
    style="text-align: center">
    <template v-if="week.intendedLearningOutcomes.indexOf(ilo.label) > -1">x</template>
    <template v-else>&nbsp;</template>
  </td>

</tr>
</template>

<script>
export default {
  name: 'activity-week',
  props: {
    week: Object,
    weeks: Object,
    totalWeeks: Number,
    index: Number,
    syllabus: Object
  },

  methods: {
    onChangeUntil() {
      this.$emit('change-until')
    },

    // taken from OutcomeMapper
    boxOver(cloLabel, poLabel) {
      // sample style
      // this.$refs['po-' + poLabel][0].style.backgroundColor = '#ccc'
      this.$refs['box-' + cloLabel + '-' + poLabel][0].style.backgroundColor = '#ccc'
      this.$emit('over', poLabel)
    },

    boxOut(cloLabel, poLabel) {
      // sample style
      // this.$refs['po-' + poLabel][0].style.backgroundColor = null
      this.$refs['box-' + cloLabel + '-' + poLabel][0].style.backgroundColor = null
      this.$emit('out', poLabel)
    },

    boxClick(index, label) {
      let arr = this.week.intendedLearningOutcomes
      // if label exists in arr, remove it
      if (arr.indexOf(label) > -1) {
        var set = new Set(arr)
        set.delete(label)
      }
      else {
        arr.push(label)
        var set = new Set(arr)
      }
      this.week.intendedLearningOutcomes = Array.from(set)
    },
  }
}
</script>
