<template>
<div v-if="syllabus">
  <hr>
  <div>Version: {{ syllabus.content.version }}</div>
  <div>Editor: {{ editor.fname + ' ' + editor.mname + ' ' + editor.lname }}</div>
  <hr>
  
  <h4>Program Outcomes</h4>
  <div :ref="'po-' + po.label" :key="po.label" v-for="po in syllabus.content.programOutcomes">
    <div>
      {{ po.label + '. ' + po.content }}
    </div>
  </div>

  <br>

  <table border="1">
    <tr>
      <th style="width: 50%">Course Learning Outcomes (CLO)</th>
      <th :colspan="syllabus.content.programOutcomes.length">Program Outcomes</th>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td :key="po.label" v-for="po in syllabus.content.programOutcomes"
        style="text-align: center">{{ po.label }}</td>
    </tr>
    <tr :key="clo.label" v-for="(clo, cloIndex) in syllabus.content.courseLearningOutcomes">
      <td>{{ clo.label + '. ' + clo.content }}</td>
      <td
        @mouseover="poBoxOver(clo.label, po.label)"
        @mouseout="poBoxOut(clo.label, po.label)"
        @click="poBoxClick(cloIndex, po.label)"
        :ref="'poBox-' + clo.label + '-' + po.label"
        :key="po.label" v-for="po in syllabus.content.programOutcomes"
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
    url: '/syllabi/cid',
    syllabus: null,
    editor: null,
    poLabels: []
  }),
  
  methods: {
    onCourseSelected(course) {
      // check for course latest syllabus
      this.$http.post(this.url, qs.stringify({
        courseId: course.id
      })).then((res) => {
        console.log(res.data)
        if (!res.data.success) {
          throw new Error
        }
        let sContent = JSON.parse(res.data.syllabus.content)
        // display syllabus info
        this.syllabus = res.data.syllabus
        this.syllabus.content = sContent
        this.editor = sContent.editor
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
      let arr = this.syllabus.content.courseLearningOutcomes[index].programOutcomes
      // if label exists in arr, remove it
      if (arr.indexOf(label) > -1) {
        var set = new Set(arr)
        set.delete(label)
      }
      else {
        arr.push(label)
        var set = new Set(arr)
      }
      this.syllabus.content.courseLearningOutcomes[index].programOutcomes = Array.from(set)
    }
  }
}
</script>
