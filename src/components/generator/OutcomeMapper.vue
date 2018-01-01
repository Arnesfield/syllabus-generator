<template>
<div v-if="syllabus">
  
  <h4>Program Outcomes</h4>
  <div :ref="'po-' + po.label" :key="po.label" v-for="po in syllabus.content.programOutcomes">
    <div>
      {{ po.label + '. ' + po.content }}
    </div>
  </div>

  <br>

  <outcome-table
    ref="cloTable"
    :main="syllabus.content.courseLearningOutcomes"
    :supporting="syllabus.content.programOutcomes"
    supportingFieldName="programOutcomes"
    title="Course Learning Outcomes (CLO)"
    supportingTitle="Program Outcomes"
    @over="poBoxOver"
    @out="poBoxOut"
    @add="cloAdd"
    @remove="cloRemove"/>

  <br>

  <outcome-table
    ref="iloTable"
    :main="syllabus.content.intendedLearningOutcomes"
    :supporting="syllabus.content.courseLearningOutcomes"
    supportingFieldName="courseLearningOutcomes"
    title="Intended Learning Outcomes (ILO)"
    supportingTitle="Course Learning Outcomes (CLO)"
    @over="cloBoxOver"
    @out="cloBoxOut"/>
  
</div>
</template>

<script>
import qs from 'qs'
import OutcomeTable from './outcomeMapper/OutcomeTable.vue'

export default {
  name: 'outcome-mapper',
  components: {
    OutcomeTable
  },
  props: {
    course: Object
  },
  data: () => ({
    url: '/syllabi/cid',
    syllabus: null,
    editor: null,
    poLabels: []
  }),

  watch: {
    course(to, from) {
      if (to === null) return;
      // check for course latest syllabus
      this.$http.post(this.url, qs.stringify({
        courseId: this.course.id
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
        // set syllabus in generator
        this.$emit('syllabus-fetched', this.syllabus, this.editor)
      }).catch(e => {
        this.syllabus = null
        this.editor = null
        this.poLabels = []
        this.$emit('syllabus-fetched', this.syllabus, this.editor)
        console.error(e)
      })
    }
  },
  
  methods: {
    poBoxOver(label) {
      // sample style
      this.$refs['po-' + label][0].style.backgroundColor = '#ccc'
    },
    poBoxOut(label) {
      // sample style
      this.$refs['po-' + label][0].style.backgroundColor = null
    },
    cloAdd(index) {
      // move ilo clo with index
      let ilo = this.syllabus.content.intendedLearningOutcomes
      ilo.forEach((e, i) => {
        let clo = e.courseLearningOutcomes
        let updated = clo.map(c => {
          let num = Number(c)
          // if clo (num) is greater
          return num > index ? String(num + 1) : String(c)
        })
        ilo[i].courseLearningOutcomes = updated
      })
    },
    cloRemove(index) {
      let ilo = this.syllabus.content.intendedLearningOutcomes
      ilo.forEach((e, i) => {
        let clo = e.courseLearningOutcomes
        let updated = clo.reduce((filtered, c) => {
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
        ilo[i].courseLearningOutcomes = updated
      })
    },

    cloBoxOver(label) {
      // sample style
      // assert that 'label' is the same as the supporting
      this.$refs.cloTable.$refs['content-' + label][0].style.backgroundColor = '#ccc'
    },
    cloBoxOut(label) {
      // sample style
      this.$refs.cloTable.$refs['content-' + label][0].style.backgroundColor = null
    }
  }
}
</script>
