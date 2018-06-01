<template>
<div v-if="syllabus">

  <iframe
    v-if="dPdf && encoded"
    :src="encoded"
    frameborder="0"
    ref="pdfContainer"
    class="syllabus-pdf-viewer"
    :style="{ height: pdfHeight }"
  ></iframe>

  <div
    v-if="dPdf && !encoded"
    class="text-xs-center pa-3 caption"
  >Loading...</div>

  <div
    ref="container"
    :style="dPdf != false ? { height: 0, overflow: 'hidden' } : { height: standardHeight }"
    :class="{ 'syllabus-container-large': !dPdf }"
    v-if="c"
  >
    <div
      ref="page1"
      class="paper-8-5-13 elevation-4 syllabus-inst"
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
            
            <div v-if="c.programOutcomes">
              <curriculum-view
                :item="c.programOutcomes"
                item-class=""
                class=""
              />
            </div>

            <!-- <div v-if="c.programOutcomes && c.programOutcomes.content && c.programOutcomes.content.length">
              <div
                :key="i"
                v-for="(po, i) in c.programOutcomes.content"
              >{{ po.label + '. ' + po.text }}</div>
            </div> -->

          </td>
        </tr>
      </table>
    </div>

    <div
      ref="page2"
      class="paper-8-5-13 elevation-4 syllabus-inst"
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

      <table border="1" v-if="c.course && c.programOutcomes && c.programOutcomes.content">
        <!-- clo -->
        <tr>
          <th
            :colspan="c.programOutcomes.content.length + 3"
          >Course Outcomes and Relationship to Program Outcomes</th>
        </tr>

        <tr>
          <th colspan="2" style="width: 50%">Course Learning Outcomes (CLO)</th>
          <th :colspan="c.programOutcomes.content.length">Program Outcomes</th>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
          <template v-if="c.programOutcomes.content.length">
            <td
              :key="po.label"
              v-for="(po, index) in c.programOutcomes.content"
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
          <template v-if="c.programOutcomes.content.length">
            <td
              :key="poIndex"
              v-for="(po, poIndex) in c.programOutcomes.content"
              class="text-xs-center"
            >
              <span
                v-if="
                  typeof c.cloPoMap[cloIndex] !== 'undefined' &&
                  Object.keys(c.cloPoMap[cloIndex]).indexOf(po.label) > -1
                "
                :title="c.cloPoMap[cloIndex][po.label].text"
              >{{ c.cloPoMap[cloIndex][po.label].symbol }}</span>
              <template v-else>&nbsp;</template>
            </td>
          </template>
          <td v-else>&nbsp;</td>
        </tr>

      </table>
    </div>

    <div
      ref="page3"
      class="paper-8-5-13 elevation-4 syllabus-inst"
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
          <td class="text-xs-center">Faculty</td>
          <td class="text-xs-center">Student</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>

        <!-- week -->

        <template v-if="c.weeklyActivities">
          <tr
            :key="'act-' + i"
            v-for="(act, i) in c.weeklyActivities"
          >
            <td class="text-xs-center">
              <div v-text="getWeeks(act, i)"></div>
              <div>({{ act.noOfHours }} hrs)</div>
            </td>
            
            <template v-if="act.asObject">

              <td>
                <ul>
                  <li
                    :key="'ilo-' + i"
                    v-for="(ilo, i) in act.ilo"
                    v-html="$md.makeHtml(ilo)"
                  />
                </ul>
              </td>
              
              <td>
                <ul>
                  <li
                    :key="'topic-' + i"
                    v-for="(topic, i) in act.topics"
                    v-html="$md.makeHtml(topic)"
                  />
                </ul>
              </td>
              
              <td>
                <ul>
                  <li
                    :key="'tlaFaculty-' + i"
                    v-for="(tla, i) in act.tlaFaculty"
                    v-html="$md.makeHtml(tla)"
                  ></li>
                </ul>
              </td>

              <td>
                <ul>
                  <li
                    :key="'tlaStudent-' + i"
                    v-for="(tla, i) in act.tlaStudent"
                    v-html="$md.makeHtml(tla)"
                  ></li>
                </ul>
              </td>

              <td>
                <ul>
                  <li
                    :key="'assessmentTasks-' + i"
                    v-for="(task, i) in act.assessmentTasks"
                    v-html="$md.makeHtml(task)"
                  ></li>
                </ul>
              </td>

              <td>
                <template
                  v-for="(clo, i) in sortCloMap(act.cloMap)"
                >{{ clo+1 }}{{ i != act.cloMap.length-1 ? ', ' : '' }}</template>
              </td>

            </template>

            <template v-else>
              <td colspan="6">
                <div v-html="$md.makeHtml(act.text)"></div>
              </td>
            </template>

          </tr>
        </template>

        <tr>
          <td class="text-xs-center">
            <strong>{{ totalHours }} hrs</strong>
          </td>
          <td colspan="6">
            <strong>Total Hours</strong>
          </td>
        </tr>

      </table>
    </div>

    <div
      ref="page4"
      class="paper-8-5-13 elevation-4 syllabus-inst"
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
                v-html="$md.makeHtml(item)"
              ></li>
            </ul>
          </td>
        </tr>
      </table>

      <table border="1" class="mt-3 syllabus-tbl">
        <tr>
          <th style="width: 1px">CLO</th>
          <th>Summative Assessment Task (SAT)</th>
        </tr>
        <tr :key="'sat-' + clo" v-for="(_, clo) in c.cloPoMap">
          <td class="text-xs-center">{{ Number(clo)+1 }}</td>
          <td>
            <template
              v-for="(task, j) in y = sat(clo)"
            >{{ task }}{{ j != y.length-1 ? ', ' : '' }}</template>
          </td>
        </tr>
      </table>

      <table border="1" class="mt-3 syllabus-tbl">
        <tr>
          <th :colspan="c.gradingSystem.length">Grading System</th>
        </tr>
        <template v-if="c.gradingSystem">
          <tr>
            <td
              :key="i"
              :style="{ width: 100 / c.gradingSystem.length + '%' }"
              class="text-xs-center bold"
              v-for="(item, i) in c.gradingSystem"
              v-html="$md.makeHtml(item.label)"
            />
          </tr>
          <tr>
            <td
              :key="i"
              v-for="(item, i) in c.gradingSystem"
              v-html="$md.makeHtml(item.text)"
            />
          </tr>
        </template>
      </table>
    </div>

    <div
      ref="page5"
      class="paper-8-5-13 elevation-4 syllabus-inst"
      v-if="c.bookReferences"
    >
      <table border="1" class="syllabus-tbl">
        <tr>
          <th>References/Online References</th>
        </tr>
        <tr v-if="c.bookReferences.length">
          <td>
            <div>
              <div
                :key="'book-' + i"
                v-html="$md.makeHtml(book)"
                v-for="(book, i) in c.bookReferences"
              />
            </div>
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
            <br><br><br>
            
            <div
              class="text-xs-center underline"
              v-text="$wrap.fullname(c.facultyInCharge)"
            />
            <div class="text-xs-center">Faculty-In-Charge</div>
            
            <br><br>
            
          </td>

          <td rowspan="3">
            <br><br><br>
            <syllabus-users :levels="approvedBy"/>
            <br><br>
          </td>

          <td rowspan="3">
            <br><br>

            <div class="text-xs-center">Version</div>
            <div
              v-if="typeof syllabus.version === 'string' && syllabus.version.length"
              class="text-xs-center"
              v-text="syllabus.version"
            />

            <br><br>

            <div class="text-xs-center">Date Modified:</div>
            <div
              class="text-xs-center"
              v-text="
                syllabus.updated_at
                ? $moment.unix(syllabus.updated_at).format('MMMM D, YYYY')
                : $moment().format('MMMM D, YYYY')
              "
            />

          </td>

        </tr>
        <tr>
          <th class="th-left">Evaluated by:</th>
        </tr>
        <tr>
          <br><br><br>
          <syllabus-users
            :levels="evaluatedBy"
            :filter="(e) => e.status != 2"
          />
          <br><br>
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
import CourseUnits from '@/include/CourseUnits'
import SyllabusUsers from '@/include/SyllabusUsers'
import DialogLoading from '@/include/dialogs/DialogLoading'
import CurriculumView from '@/include/CurriculumView'
import getWeeks from '@/assets/js/getWeeks'
import getTotalOf from '@/assets/js/getTotalOf'

export default {
  name: 'syllabus-inst',
  components: {
    CourseUnits,
    SyllabusUsers,
    DialogLoading,
    CurriculumView
  },
  props: {
    value: Object,
    assign: Object,
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
    syllabus: null,
    encoded: null,
    pages: {
      1: null,
      2: null,
      3: null,
      4: null,
      5: null
    },
    dPdf: false
  }),

  watch: {
    pdf(e) {
      this.dPdf = e
    },
    dPdf(e) {
      this.$emit('update:pdf', e)
    },
    value(e) {
      this.syllabus = e
    },
    syllabus: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
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
    this.syllabus = this.value
    this.dPdf = this.pdf
  },

  computed: {
    c() {
      return this.syllabus ? this.syllabus.content : null
    },

    evaluatedBy() {
      let evaluatedBy = []
      if (this.assign.status == 1) {
        evaluatedBy = this.syllabus.content.evaluatedBy
      } else {
        evaluatedBy = this.assign.content.levels.reduce((filtered, e, i) => {
          let length = this.assign.content.levels.length
          if (length != 1 && length-1 > i) {
            filtered.push(e)
          }
          return filtered
        }, [])
        this.$set(this.syllabus.content, 'evaluatedBy', evaluatedBy)
      }
      return evaluatedBy
    },
    approvedBy() {
      let approvedBy = []
      if (this.assign.status == 1) {
        approvedBy = this.syllabus.content.approvedBy
      } else {
        approvedBy = [this.assign.content.levels[this.assign.content.levels.length-1]]
        this.$set(this.syllabus.content, 'approvedBy', approvedBy)
      }
      return approvedBy
    },

    totalHours() {
      return getTotalOf(this.c.weeklyActivities, 'noOfHours')
    }
  },

  methods: {
    getWeeks(act, index) {
      return getWeeks(this.c.weeklyActivities, act, index)
    },

    resetPages() {
      Object.keys(this.pages).forEach(e => {
        this.pages[e] = null
      })
    },

    generate(e) {
      this.dPdf = e
      // create only if pdf prop is true
      if (!this.dPdf) {
        return
      }

      this.resetPages()
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
      let doc = new jsPDF('p', 'in', [8.5, 13])

      let width = doc.internal.pageSize.width
      let height = doc.internal.pageSize.height

      this.encoded = null
      
      Object.keys(this.pages).forEach((e, i) => {
        if (this.pages[e]) {
          doc.addImage(this.pages[e], 'png', 0, 0, width, height)
        }
        if (Object.keys(this.pages).length-1 != i) {
          doc.addPage()
        }
      })
      let blob = doc.output('blob')
      this.encoded = URL.createObjectURL(blob)
      setTimeout(() => {
        this.$bus.$emit('dialog--loading', false)
      }, 1000)
    },

    sortCloMap(m) {
      let map = JSON.parse(JSON.stringify(m))
      return map.sort((a, b) => a - b)
    },

    instructionalMaterials() {
      if (!this.c) {
        return
      }

      let materials = this.c.weeklyActivities.reduce((filtered, e) => {
        // if activity is not object, do not include
        if (!e.asObject) {
          return filtered
        }
        let names = e.instructionalMaterials
        return filtered.concat(names)
      }, [])

      return Array.from(new Set(materials))
    },

    sat(clo) {
      if (!this.c) {
        return
      }

      let tasks = this.c.weeklyActivities.reduce((filtered, e) => {
        // if activity is not object, do not include
        if (!e.asObject) {
          return filtered
        }
        // check if clo exists in cloMap
        let names = []
        if (e.cloMap.indexOf(Number(clo)) > -1) {
          names = e.assessmentTasks
        }
        return filtered.concat(names)
      }, [])

      return Array.from(new Set(tasks))
    }
  }
}
</script>
