<template>
<div
  v-if="value"
  class="syllabus-inst elevation-4 paper-8-5-11"
>
  <div class="syllabus-content">
    <table border="1">
      <tr>
        <th>Course Code</th>
        <th>Course Title</th>
        <th>Units / Type</th>
      </tr>
      <tr>
        <td v-html="c.course.code"></td>
        <td v-html="c.course.title"></td>
        <td>
          <course-units :course="c.course"/>
        </td>
      </tr>
    </table>

    <table border="1" class="mt-3">
      <tr>
        <th>Institution Vision Statement</th>
      </tr>
      <tr>
        <td v-html="c.institutionVision"></td>
      </tr>

      <tr>
        <th>Institution Mission Statement</th>
      </tr>
      <tr>
        <td v-html="c.institutionMission"></td>
      </tr>

      <tr>
        <th>Department Vision Statement</th>
      </tr>
      <tr>
        <td v-html="c.departmentVision"></td>
      </tr>

      <tr>
        <th>Department Mission Statement</th>
      </tr>
      <tr>
        <td v-html="c.departmentMission"></td>
      </tr>

      <tr>
        <th>Program Outcomes</th>
      </tr>
      <tr>
        <td>

          <div v-if="c.programOutcomes.length">
            <div
              :key="i"
              v-for="(po, i) in c.programOutcomes"
            >{{ po.label + '. ' + po.content }}</div>
          </div>

        </td>
      </tr>
    </table>
  </div>

</div>
</template>

<script>
import CourseUnits from '@/include/CourseUnits'

export default {
  name: 'syllabus-inst',
  components: {
    CourseUnits
  },
  props: {
    syllabus: {
      type: Object,
      default: null
    }
  },
  data: () => ({
    value: null
  }),

  watch: {
    syllabus: {
      deep: true,
      handler(e) {
        this.value = e
      }
    }
  },

  created() {
    if (this.syllabus) {
      this.value = this.syllabus
    }
  },

  computed: {
    c() {
      return this.value ? this.value.content : null
    }
  }
}
</script>
