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
  <v-toolbar-title v-text="$bus.toolbar.titleContent || title"></v-toolbar-title>

  <template v-if="$route.name === 'Syllabus'">
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
    <template v-if="!$bus.toolbar.comments.model">
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

  <template v-else-if="$route.name === 'Generator' && !$bus.generator.courseRefresh">
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
      return this.$route.meta.title || this.$route.name || 'Application'
    }
  }
}
</script>
