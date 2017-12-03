<template>
<div v-if="syllabus">
  <hr>
  <div>Version: {{ syllabus.version }}</div>
  <div>Editor: {{ editor.username }}</div>
  <hr>
  
  <h4>Program Outcomes</h4>
  <div :key="po.label" v-for="po in syllabus.programOutcomes">
    <div>
      {{ po.label + '. ' + po.content }}
    </div>
    <br>
  </div>

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
    <tr :key="clo.label" v-for="clo in syllabus.courseLearningOutcomes">
      <td>{{ clo.label + '. ' + clo.content }}</td>
      <td :key="po.label" v-for="po in syllabus.programOutcomes"
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
    editor: null
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
        console.error(e)
      })
    }
  }
}
</script>
