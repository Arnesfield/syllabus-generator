<template>
<div v-if="value">

  <iframe
    v-if="pdf && encoded"
    :src="encoded"
    frameborder="0"
    ref="pdfContainer"
    class="syllabus-pdf-viewer"
    :style="{ height: pdfHeight }"
  ></iframe>

  <div
    v-if="pdf && !encoded"
    class="text-xs-center pa-3 caption"
  >Loading...</div>

  <div
    ref="container"
    :style="pdf != false ? { height: 0, overflow: 'hidden' } : { height: standardHeight }"
    :class="{ 'syllabus-container-large': !pdf }"
    v-if="c"
  >
    <div
      ref="page1"
      class="paper-8-5-11 elevation-4 syllabus-inst"
    >
      <table border="1" v-if="c.course">
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
          <th class="th-left">Institution Vision Statement</th>
        </tr>
        <tr>
          <td v-html="c.institutionVision"></td>
        </tr>

        <tr>
          <th class="th-left">Institution Mission Statement</th>
        </tr>
        <tr>
          <td v-html="c.institutionMission"></td>
        </tr>

        <tr>
          <th class="th-left">Department Vision Statement</th>
        </tr>
        <tr>
          <td v-html="c.departmentVision"></td>
        </tr>

        <tr>
          <th class="th-left">Department Mission Statement</th>
        </tr>
        <tr>
          <td v-html="c.departmentMission"></td>
        </tr>

        <tr>
          <th class="th-left">Program Outcomes</th>
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

    <div
      ref="page2"
      class="paper-8-5-11 elevation-4 syllabus-inst"
    >
      <table border="1" v-if="c.course">
        <tr>
          <th>Course Code</th>
          <th>Course Title</th>
          <th>Units / Type</th>
        </tr>
        <tr>
          <td>{{ c.course.code }}</td>
          <td>{{ c.course.title }}</td>
          <td>
            <course-units :course="c.course"/>
          </td>
        </tr>

        <tr>
          <td>Prerequisites</td>
          <template v-if="c.course.prerequisites && c.course.prerequisites.length">
            <template v-for="(p, i) in c.course.prerequisites">
              <td :key="'code-' + i">{{ p.code }}</td>
              <td :key="'title-' + i">{{ p.title }}</td>
              <span :key="'comma-' + i" v-if="c.course.prerequisites.length-1 !== i">,</span>
            </template>
          </template>
          <td colspan="2" v-else>None</td>
        </tr>

        <tr>
          <td>Corequisites</td>
          <template v-if="c.course.corequisites && c.course.corequisites.length">
            <template v-for="(p, i) in c.course.corequisites">
              <td :key="'code-' + i">{{ p.code }}</td>
              <td :key="'title-' + i">{{ p.title }}</td>
              <span :key="'comma-' + i" v-if="c.course.corequisites.length-1 !== i">,</span>
            </template>
          </template>
          <td colspan="2" v-else>None</td>
        </tr>

        <tr>
          <td>Course Description</td>
          <td colspan="2" v-html="c.course.description"></td>
        </tr>


      </table>

      <table border="1" v-if="c.course">
        <!-- clo -->
        <tr>
          <th
            :colspan="c.programOutcomes.length + 3"
          >Course Outcomes and Relationship to Program Outcomes</th>
        </tr>

        <tr>
          <th colspan="2" style="width: 50%">Course Learning Outcomes (CLO)</th>
          <th :colspan="c.programOutcomes.length">Program Outcomes</th>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
          <template v-if="c.programOutcomes.length">
            <td
              :key="po.id"
              v-for="(po, index) in c.programOutcomes"
              class="text-xs-center"
            >{{ typeof po.label !== 'undefined' ? po.label : (index + 1) }}</td>
          </template>
          <td v-else>&nbsp;</td>
        </tr>
        <tr
          :key="cloIndex"
          v-for="(clo, cloIndex) in c.courseLearningOutcomes"
        >
          <td
            colspan="2"
            style="padding: 1px"
          >{{ (cloIndex + 1) + '. ' + (clo ? clo : '') }}</td>
          <template v-if="c.programOutcomes.length">
            <td
              :key="poIndex"
              v-for="(po, poIndex) in c.programOutcomes"
              class="text-xs-center"
            >
              <template v-if="
                typeof c.cloPoMap[cloIndex] !== 'undefined' &&
                Object.keys(c.cloPoMap[cloIndex]).indexOf(po.id) > -1
              ">{{ c.cloPoMap[cloIndex][po.id].symbol }}</template>
              <template v-else>&nbsp;</template>
            </td>
          </template>
          <td v-else>&nbsp;</td>
        </tr>

      </table>
    </div>

    <div
      ref="page3"
      class="paper-8-5-11 elevation-4 syllabus-inst"
    >
      <table border="1" class="mt-3 syllabus-tbl">
        <tr>
          <th>Week / No. of Hrs.</th>
          <th>Intended Learning Outcome (ILO)</th>
          <th>Detailed Course Content</th>
          <th colspan="2">Teaching Activities and Learning Outcomes</th>
          <th>Assessment Task (AT)</th>
          <th>CLO</th>
        </tr>

        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>Faculty</td>
          <td>Student</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>

        <!-- week -->

        <tr
          v-if="c.weeklyActivities"
          :key="'act-' + i"
          v-for="(act, i) in c.weeklyActivities"
        >
          <td>{{ act.noOfWeeks }}</td>
          
          <td>
            <ul>
              <li
                :key="'ilo-' + i"
                v-for="(ilo, i) in act.ilo"
                v-html="ilo"
              ></li>
            </ul>
          </td>
          
          <td>
            <ul>
              <li
                :key="'topic-' + i"
                v-for="(topic, i) in act.topics"
              >
                <topic :topic="topic"/>
              </li>
            </ul>
          </td>
          
          <td>
            <ul>
              <li
                :key="'tlaFaculty-' + i"
                v-for="(tla, i) in act.tlaFaculty"
                v-html="tla"
              ></li>
            </ul>
          </td>

          <td>
            <ul>
              <li
                :key="'tlaStudent-' + i"
                v-for="(tla, i) in act.tlaStudent"
                v-html="tla"
              ></li>
            </ul>
          </td>

          <td>
            <ul>
              <li
                :key="'assessmentTasks-' + i"
                v-for="(task, i) in act.assessmentTasks"
                v-html="task.name"
              ></li>
            </ul>
          </td>

          <td>
            <template
              v-for="(clo, i) in act.cloMap"
            >{{ clo+1 }}{{ i != act.cloMap.length-1 ? ', ' : '' }}</template>
          </td>

        </tr>

      </table>
    </div>

    <div
      ref="page4"
      class="paper-8-5-11 elevation-4 syllabus-inst"
    >
      <table border="1" class="syllabus-tbl">
        <tr>
          <th>Instructional Materials</th>
        </tr>
        <tr v-if="(z = instructionalMaterials()).length">
          <td>
            <ul>
              <li
                :key="'instructionalMaterials-' + i"
                v-for="(item, i) in z"
                v-html="item"
              ></li>
            </ul>
          </td>
        </tr>
      </table>

      <table border="1" class="mt-3 syllabus-tbl">
        <tr>
          <th>CLO</th>
          <th>Summative Assessment Task (SAT)</th>
        </tr>
        <tr :key="'sat-' + clo" v-for="(_, clo) in c.cloPoMap">
          <td>{{ Number(clo)+1 }}</td>
          <td>
            <template
              v-for="(task, j) in y = sat(clo)"
            >{{ task }}{{ j != y.length-1 ? ', ' : '' }}</template>
          </td>
        </tr>
      </table>
    </div>

    <div
      ref="page5"
      class="paper-8-5-11 elevation-4 syllabus-inst"
      v-if="c.bookReferences"
    >
      <table border="1" class="syllabus-tbl">
        <tr>
          <th>References/Online References</th>
        </tr>
        <tr v-if="c.bookReferences.length">
          <td>
            <template
              v-for="(book, i) in c.bookReferences"
            >
              <div
                :key="'book-' + i"
                v-html="book.citation"
              ></div>
              <br
                :key="'book-br-' + i"
                v-if="c.bookReferences.length-1 != i"
              />
            </template>
          </td>
        </tr>
      </table>

      <table border="1" class="syllabus-tbl">
        <tr>
          <th class="th-left">Prepared by:</th>
          <th class="th-left">Approved by:</th>
          <th class="th-left">Version / Date:</th>
        </tr>
        <tr>
          <td>
            <br>
            <br>
            
            <div class="text-xs-center">
              <template
                v-if="c.facultyInCharge"
              >{{ c.facultyInCharge }}</template>
              <template v-else>_____________________</template>
            </div>
            <div class="text-xs-center">Faculty-In-Charge</div>
            
            <br>
            <br>

            <div>Evaluated by:</div>

            <br>
            <br>

            <div class="text-xs-center">
              <template
                v-if="c.evaluatedBy"
              >{{ c.evaluatedBy }}</template>
              <template v-else>_____________________</template>
            </div>
            <div class="text-xs-center">
              <template
                v-if="c.evaluatedByPosition"
              >{{ c.evaluatedByPosition }}</template>
              <template v-else>Coordinator</template>
            </div>

            <br>
            <br>

          </td>

          <td>
            <template v-if="c.approvedBy">
              <template v-for="(by, i) in c.approvedBy">
                <br :key="'br1-' + i">
                <br :key="'br2-' + i">

                <div
                  :key="'name-' + i"
                  class="text-xs-center"
                >
                  <template
                    v-if="by.name"
                  >{{ by.name }}</template>
                  <template v-else>_____________________</template>
                </div>
                <div
                  :key="'position-' + i"
                  class="text-xs-center"
                >
                  <template
                    v-if="by.position"
                  >{{ by.position }}</template>
                  <template v-else>Director</template>
                </div>
              </template>
            </template>
          </td>

          <td>
            <br>
            <br>

            <div class="text-xs-center">Version</div>
            <div
              v-if="syllabus.version"
              class="text-xs-center"
            >syllabus.version</div>

            <br>
            <br>

            <div class="text-xs-center">Date Modified:</div>
            <div
              v-if="syllabus.updated_at"
              class="text-xs-center"
            >{{ $wrap.date(syllabus.updated_at, false) }}</div>

          </td>

        </tr>
      </table>

    </div>


  </div>

  <dialog-loading/>

</div>
</template>

<script>
import jsPDF from 'jspdf'
import html2canvas from 'html2canvas'
import Topic from '@/components/generator/activityManager/activityWeek/topicPicker/Topic'
import CourseUnits from '@/include/CourseUnits'
import DialogLoading from '@/include/dialogs/DialogLoading'

export default {
  name: 'syllabus-inst',
  components: {
    Topic,
    CourseUnits,
    DialogLoading
  },
  props: {
    syllabus: {
      type: Object,
      default: null
    },
    pdf: {
      type: Boolean,
      default: false
    },
    pdfHeight: {
      type: String,
      default: '480px'
    },
    standardHeight: {
      type: String,
      default: '480px'
    }
  },
  data: () => ({
    value: null,
    encoded: null,
    pages: {
      1: null,
      2: null,
      3: null,
      4: null,
      5: null
    }
  }),

  watch: {
    syllabus: {
      deep: true,
      handler(e) {
        if (e !== null) {
          this.value = e
        }
      }
    },
    pages: {
      deep: true,
      handler(e) {
        // check if all fields are not null
        let proceed = Object.keys(this.pages).every(e => e !== null)

        if (!proceed) {
          return
        }

        this.generatePDF()
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
  },

  methods: {
    generate(e) {
      this.pdf = e
      // create only if pdf prop is true
      if (!this.pdf) {
        return
      }

      // do loading
      this.$bus.$emit('dialog--loading', true)
      Object.keys(this.pages).forEach(e => {
        html2canvas(this.$refs['page' + e]).then((canvas) => {
          this.pages[e] = canvas.toDataURL('img/png')
        })
      })
      // let doc = new jsPDF('p', 'mm', 'letter')
      // let width = doc.internal.pageSize.width
      // let height = doc.internal.pageSize.height
      // var options = {
      //   pagesplit: true
      // }

      // doc.addHTML(this.$refs.page1, options, () => {
      //   doc.save('test.pdf')
      // }).then(canvas => {
      //   // doc.addImage(canvas, 'png', 0, 0, width, height)
      //   let blob = doc.output('blob')
      //   this.encoded = URL.createObjectURL(blob)
      // })
    },

    generatePDF() {
      let doc = new jsPDF('p', 'mm', 'letter')

      let width = doc.internal.pageSize.width
      let height = doc.internal.pageSize.height

      this.encoded = null
      
      new Promise((resolve, reject) => {
        setTimeout(() => {
          Object.keys(this.pages).forEach((e, i) => {
            doc.addImage(this.pages[e], 'png', 0, 0, width, height)
            if (Object.keys(this.pages).length-1 != i) {
              doc.addPage()
            }
          })
          let blob = doc.output('blob')
          resolve(blob)
        }, 10)
      }).then(blob => {
        this.encoded = URL.createObjectURL(blob)
        this.$bus.$emit('dialog--loading', false)
      })
    },

    instructionalMaterials() {
      if (!this.c) {
        return
      }

      let materials = this.c.weeklyActivities.reduce((filtered, e) => {
        let names = e.instructionalMaterials.map(e => e.name)
        return filtered.concat(names)
      }, [])

      return Array.from(new Set(materials))
    },

    sat(clo) {
      if (!this.c) {
        return
      }

      let tasks = this.c.weeklyActivities.reduce((filtered, e) => {
        // check if clo exists in cloMap
        let names = []
        if (e.cloMap.indexOf(Number(clo)) > -1) {
          names = e.assessmentTasks.map(e => e.name)
        }
        return filtered.concat(names)
      }, [])

      return Array.from(new Set(tasks))
    }
  }
}
</script>
