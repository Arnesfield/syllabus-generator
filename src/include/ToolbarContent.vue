<template>
<v-toolbar
  flat
  dark
  :tabs="typeof $bus.tabs[$route.name] !== 'undefined'"
  :absolute="false"
  :fixed="false"
  class="primary lighten-1"
>
  <v-btn icon dark @click="$bus.navToggle">
    <v-icon>{{ $route.meta.icon }}</v-icon>
  </v-btn>
  <v-toolbar-title v-text="title"></v-toolbar-title>

  <template v-if="checkRoute(['Syllabus', 'SyllabusView'])">
    <v-spacer/>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.$emit('syllabus--pdf.toggle')"
      >
        <v-icon v-if="$bus.toolbar.comments.pdf">subject</v-icon>
        <v-icon v-else>picture_as_pdf</v-icon>
      </v-btn>
      <span v-if="$bus.toolbar.comments.pdf">View standard</span>
      <span v-else>View as PDF</span>
    </v-tooltip>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.$emit('syllabus--info.show')"
      >
        <v-icon>info_outline</v-icon>
      </v-btn>
      <span>View info</span>
    </v-tooltip>
    <template v-if="checkRoute('SyllabusView')">
      <btn-refresh tip="bottom"/>
    </template>
    <template v-else-if="checkRoute('Syllabus') && !$bus.toolbar.comments.model">
      <btn-refresh tip="bottom"/>
      <v-tooltip bottom>
        <v-btn
          icon
          slot="activator"
          @click="$bus.toolbar.comments.model = true"
        >
          <v-icon>chevron_left</v-icon>
        </v-btn>
        <span>Reveal</span>
      </v-tooltip>
    </template>
  </template>

  <template v-else-if="checkRoute('Generator') && !$bus.generator.courseRefresh">
    <v-spacer/>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.$emit('generator--undo')"
      >
        <v-icon>undo</v-icon>
      </v-btn>
      <span>Undo changes</span>
    </v-tooltip>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.$emit('generator--info.show')"
      >
        <v-icon>info_outline</v-icon>
      </v-btn>
      <span>View info</span>
    </v-tooltip>
  </template>

  <template v-if="checkRoute('CourseTree')">
    <v-spacer/>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.toolbar.course.collapse = !$bus.toolbar.course.collapse"
      >
        <v-icon v-if="$bus.toolbar.course.collapse">expand_more</v-icon>
        <v-icon v-else>expand_less</v-icon>
      </v-btn>
      <span v-if="$bus.toolbar.course.collapse">Expand</span>
      <span v-else>Collapse</span>
    </v-tooltip>

    <template v-if="!$bus.toolbar.course.model">
      <btn-refresh tip="bottom"/>
      <v-tooltip bottom>
        <v-btn
          icon
          slot="activator"
          @click="$bus.toolbar.course.model = true"
        >
          <v-icon>chevron_left</v-icon>
        </v-btn>
        <span>Reveal</span>
      </v-tooltip>
    </template>

  </template>

  <template v-if="checkRoute('ManageOutcomes')">
    <v-spacer/>

    <template v-if="!$bus.toolbar.outcomes.model">
      <btn-refresh tip="bottom"/>
    </template>

  </template>

  <template v-if="checkRoute('OutcomesExplorer')">
    <v-spacer/>

    <template v-if="!$bus.toolbar.outcomes.model">
      <btn-refresh tip="bottom"/>
      <v-tooltip bottom>
        <v-btn
          icon
          slot="activator"
          @click="$bus.toolbar.outcomes.model = true"
        >
          <v-icon>chevron_left</v-icon>
        </v-btn>
        <span>Reveal</span>
      </v-tooltip>
    </template>

  </template>

  <v-tabs
    align-with-title
    show-arrows
    color="primary lighten-1"
    v-if="typeof $bus.tabs[$route.name] !== 'undefined' && $bus.tabs[$route.name].tabs"
    v-model="$bus.tabs[$route.name].tab"
    slot="extension">
    <v-tab
      v-for="tab in $bus.tabs[$route.name].items"
      :key="tab">{{ tab }}</v-tab>
  </v-tabs>

</v-toolbar>
</template>

<script>
import BtnRefresh from '@/include/BtnRefresh'

export default {
  name: 'toolbar-content',
  components: {
    BtnRefresh
  },
  computed: {
    title() {
      return this.$bus.toolbar.titleContent ||
        this.$route.meta.title ||
        this.$route.name ||
        'Application'
    }
  },
  methods: {
    checkRoute(arr) {
      if (typeof arr !== 'object') {
        arr = [arr]
      }
      return arr.includes(this.$route.name)
    }
  }
}
</script>
