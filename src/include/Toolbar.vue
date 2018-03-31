<template>
  <v-toolbar
    app
    dark
    :clipped-left="$bus.nav.clipped"
    color="primary"
  >
    <v-toolbar-side-icon @click.stop="$bus.navToggle"/>
    <router-link to="/" class="white--text clean-a">
      <v-toolbar-title>Forge</v-toolbar-title>
    </router-link>

    <template v-if="$route.name === 'Generator'">
      <v-spacer/>
      <v-tooltip bottom v-if="$bus.generator.allowEdit">
        <v-btn
          icon
          @click="$bus.generator.suggestions = !$bus.generator.suggestions"
          slot="activator">
          <v-icon v-if="$bus.generator.suggestions">visibility</v-icon>
          <v-icon v-else>visibility_off</v-icon>
        </v-btn>
        <span v-if="$bus.generator.suggestions">Hide Suggestions</span>
        <span v-else>Show Suggestions</span>
      </v-tooltip>
      <btn-refresh
        tip="bottom"
        v-if="$bus.generator.courseRefresh"
      />

      <template v-if="$bus.generator.allowEdit">

        <v-btn
          class="mr-3 hidden-sm-and-down"
          outline
          @click="$bus.$emit('generator--save')"
          :loading="$bus.progress.circular.Generator.save"
          :disabled="$bus.progress.circular.Generator.save"
        >Save</v-btn>

        <v-tooltip bottom class="hidden-md-and-up">
          <v-btn
            icon
            @click="$bus.$emit('generator--save')"
            slot="activator"
          >
            <v-progress-circular
              indeterminate
              :width="6"
              :size="18"
              v-if="$bus.progress.circular.Generator.save"
            />
            <v-icon v-else>save</v-icon>
          </v-btn>
          <span v-if="$bus.progress.circular.Generator.save">Saving</span>
          <span v-else>Save</span>
        </v-tooltip>
        
      </template>

    </template>

    <template v-if="$route.name === 'Workflow' || $route.name === 'Assignments'">
      <v-spacer/>
      <btn-refresh/>
      <v-tooltip bottom>
        <v-btn
          icon
          slot="activator"
          @click="$bus.toolbar.listView = !$bus.toolbar.listView"
        >
          <v-icon v-if="!$bus.toolbar.listView">view_list</v-icon>
          <v-icon v-else>view_module</v-icon>
        </v-btn>
        <span v-if="!$bus.toolbar.listView">View as list</span>
        <span v-else>View as grid</span>
      </v-tooltip>

      <v-tooltip bottom>
        <v-btn
          icon
          slot="activator"
          @click="$bus.toolbar.sortByStatus = !$bus.toolbar.sortByStatus"
        >
          <v-icon v-if="$bus.toolbar.sortByStatus">date_range</v-icon>
          <v-icon v-else>sort</v-icon>
        </v-btn>
        <span v-if="$bus.toolbar.sortByStatus">By date</span>
        <span v-else>By status</span>
      </v-tooltip>
    </template>

    <template
      v-if="
        $route.name === 'ManageUsers' ||
        $route.name === 'ManageCourses' ||
        $route.name === 'ManageBooks' ||
        $route.name === 'ManageCurriculum'
      "
    >
      <v-spacer/>
      <btn-refresh/>
    </template>

  </v-toolbar>
</template>

<script>
import BtnRefresh from '@/include/BtnRefresh'

export default {
  name: 'toolbar',
  components: {
    BtnRefresh
  }
}
</script>
