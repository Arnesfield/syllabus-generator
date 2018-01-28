<template>
<div v-if="course">
  <v-alert class="elevation-1" type="info" :value="true"
    v-if="selected && typeof selected.version !== 'undefined'">
    Based on syllabi version: <strong>v{{ selected.version }}</strong>
  </v-alert>
  <v-alert class="elevation-1" type="warning" :value="true"
    v-else-if="syllabi.length">This course has an existing syllabus you can use as reference.</v-alert> 
  <v-alert class="elevation-1" type="info" :value="true" v-else>No existing syllabus. Syllabus started from scratch.</v-alert>

  <v-btn class="primary" style="margin-right: 0" @click="startScratch">New</v-btn>
  <v-menu botom transition="slide-y-transition" @input="getSyllabi(true)">
    <v-btn slot="activator"
      v-if="selected && typeof selected.version !== 'undefined'">
      <span style="text-transform: lowercase">v</span>{{ selected.version }}
    </v-btn>
    <v-btn v-else slot="activator">Exisiting</v-btn>
    <v-list>
      <v-list-tile v-for="(s, i) in syllabi" :key="s.id" @click="selected = syllabi[i]">
        v{{ s.version }}
      </v-list-tile>
    </v-list>
  </v-menu>
</div>
</template>

<script>
import qs from 'qs'

export default {
  name: 'syllabus-picker',
  props: {
    course: Object
  },
  data: () => ({
    url: '/syllabi/cid',
    syllabi: [],
    selected: null,
    showSyllabi: false,
    // pause for confirmation
    confirmPause: false
  }),

  watch: {
    course(to, from) {
      // if null, just clear
      this.clear()
      if (to !== null) {
        this.getSyllabi()
      }
    },

    selected(to, from) {
      if (to !== null) {
        // confirm first if selected has been set
        if (!this.confirmPause && from !== null && this.onChangeConfirm()) {
          this.confirmPause = true
          this.selected = from
          return
        } else {
          this.confirmPause = false
        }
        // hide list
        this.showSyllabi = false
      }
      this.$emit('syllabus-selected', to)
    }
  },

  created() {
    // once a course is selected,
    // check if the course has an exisiting syllabus
    // let user decide to use past syllabi
    // or create new one
    // show all those syllabus in DESC order
    if (this.course !== null) {
      this.getSyllabi()
    }
  },

  methods: {
    clear() {
      this.syllabi = []
      this.selected = null
      this.confirmPause = false
    },

    onChangeConfirm(msg) {
      return this.selected !== null
        ? !confirm('Choosing a different syllabus will erase your current edit data. Continue?')
        : false
    },

    getSyllabi(show) {
      show = typeof show !== 'boolean' ? false : show
      // if already loaded
      // show syllabi
      if (show === false && this.syllabi.length) {
        this.showSyllabi = true
        return
      }

      this.$http.post(this.url, qs.stringify({
        courseId: this.course.id
      })).then((res) => {
        let syllabi = res.data.syllabi
        // if no syllabi, create new syllabi from scratch
        if (typeof syllabi !== 'object') {
          // start scratch only if not clicked on check existing
          if (show === false) {
            this.startScratch()
          }
        } else {
          // convert only if show
          if (show) {
            // convert content json str to json obj
            syllabi.forEach(e => {
              if (typeof e.content === 'string') {
                e.content = JSON.parse(e.content)
              }
            })
          }
          // set
          this.syllabi = syllabi
          // show syllabi
          this.showSyllabi = typeof show !== 'boolean' ? false : show
        }
      }).catch(e => {
        this.syllabi = []
        console.error(e)
      })
    },

    startScratch() {
      // syllabus structure here
      let syllabus = {
        course_id: this.course.id,
        content: {
          bookReferences: [],
          programOutcomes: [],
          courseLearningOutcomes: [],
          intendedLearningOutcomes: [],
          cloPoMap: {},
          weeklyActivities: []
        }
      }

      this.selected = syllabus
      // if successfully changed
      if (this.selected === syllabus) {
        // hide syllabi list
        this.showSyllabi = false
      }
    }
  }
}
</script>
