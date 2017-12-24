<template>
<div v-if="syllabus">
  <hr>
  <div>Version: {{ syllabus.version }}</div>
  <div>Editor: {{ editor.username }}</div>
  <hr>
  
  <h4>Program Outcomes</h4>
  <div :ref="'po-' + po.label" :key="po.label" v-for="po in syllabus.programOutcomes">
    <div>
      {{ po.label + '. ' + po.content }}
    </div>
  </div>

  <br>

  <table border="1">
    <tr>
      <th style="width: 50%">Course Learning Outcomes (CLO)</th>
      <th :colspan="syllabus.programOutcomes.length">Program Outcomes</th>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td :key="po.label" v-for="po in syllabus.programOutcomes"
        style="text-align: center">{{ po.label }}</td>
    </tr>
    <tr :key="clo.label" v-for="(clo, cloIndex) in syllabus.courseLearningOutcomes">
      <td>{{ clo.label + '. ' + clo.content }}</td>
      <td
        @mouseover="poBoxOver(clo.label, po.label)"
        @mouseout="poBoxOut(clo.label, po.label)"
        @click="poBoxClick(cloIndex, po.label)"
        :ref="'poBox-' + clo.label + '-' + po.label"
        :key="po.label" v-for="po in syllabus.programOutcomes"
        style="text-align: center">
        <template v-if="clo.programOutcomes.indexOf(po.label) > -1">x</template>
        <template v-else>&nbsp;</template>
      </td>
    </tr>
  </table>
</div>
</template>

<script>
import qs from 'qs'

export default {
  name: 'outcome-mapper',
  data: () => ({
    url: '/syllabus',
    syllabus: null,
    editor: null,
    poLabels: []
  }),
  
  methods: {
    onCourseSelected(course) {
      // check for course latest syllabus
      this.$http.post(this.url, qs.stringify({
        courseId: course._id
      })).then((res) => {
        console.log(res.data)
        if (!res.data.success) {
          throw new Error
        }
        // display syllabus info
        this.syllabus = res.data.syllabus
        this.editor = res.data.editor
      }).catch(e => {
        this.syllabus = null
        this.editor = null
        this.poLabels = []
        console.error(e)
      })
    },

    poBoxOver(cloLabel, poLabel) {
      // sample style
      this.$refs['po-' + poLabel][0].style.backgroundColor = '#ccc'
      this.$refs['poBox-' + cloLabel + '-' + poLabel][0].style.backgroundColor = '#ccc'
    },

    poBoxOut(cloLabel, poLabel) {
      // sample style
      this.$refs['po-' + poLabel][0].style.backgroundColor = null
      this.$refs['poBox-' + cloLabel + '-' + poLabel][0].style.backgroundColor = null
    },

    poBoxClick(index, label) {
      let arr = this.syllabus.courseLearningOutcomes[index].programOutcomes
      // if label exists in arr, remove it
      if (arr.indexOf(label) > -1) {
        var set = new Set(arr)
        set.delete(label)
      }
      else {
        arr.push(label)
        var set = new Set(arr)
      }
      this.syllabus.courseLearningOutcomes[index].programOutcomes = Array.from(set)
    }
  }
}
</script>
