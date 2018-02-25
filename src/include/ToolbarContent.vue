<template>
  <v-toolbar
    flat
    dark
    :tabs="typeof $bus.tabs[$route.name] !== 'undefined'"
    :absolute="false"
    :fixed="false"
    class="primary lighten-1"
  >
    <v-btn icon dark>
      <v-icon>{{ $route.meta.icon }}</v-icon>
    </v-btn>
    <v-toolbar-title v-text="title"></v-toolbar-title>

    <template v-if="$route.name === 'Generator'">
      <v-spacer/>
      <v-tooltip bottom>
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
      <v-tooltip bottom>
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
        <span>Save</span>
        <span v-if="$bus.progress.circular.Generator.save">Saving</span>
        <span v-else>Save</span>
      </v-tooltip>
      <v-tooltip
        bottom
        v-if="$bus.generator.courseRefresh"
      >
        <v-btn
          icon
          @click="$bus.$emit('generator--course.refresh')"
          slot="activator"
        >
          <v-progress-circular
            indeterminate
            :width="6"
            :size="18"
            v-if="$bus.progress.circular.Generator.course"
          />
          <v-icon v-else>refresh</v-icon>
        </v-btn>
        <span v-if="$bus.progress.circular.Generator.course">Refreshing</span>
        <span v-else>Refresh</span>
      </v-tooltip>
      <!-- <v-menu
        :close-on-content-click="false"
        bottom left offset-y>
        <v-btn icon slot="activator" dark>
          <v-icon>more_vert</v-icon>
        </v-btn>
        <v-list>
          <v-list-tile>
            <v-list-tile-action>
              <v-switch v-model="$bus.generator.suggestions"/>
            </v-list-tile-action>
            <v-list-tile-title>Show suggestions</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu> -->
    </template>

    <template v-if="$route.name === 'Assign'">
      <v-spacer/>
      <v-tooltip left>
        <v-btn
          icon
          @click="$bus.$emit('workflow--refresh')"
          slot="activator"
        >
          <v-progress-circular
            indeterminate
            :width="6"
            :size="18"
            v-if="$bus.progress.circular.Assign.refresh"
          />
          <v-icon v-else>refresh</v-icon>
        </v-btn>
        <span v-if="$bus.progress.circular.Assign.refresh">Refreshing</span>
        <span v-else>Refresh</span>
      </v-tooltip>
    </template>

    <template v-if="$route.name === 'Assignments'">
      <v-spacer/>
      <v-tooltip left>
        <v-btn
          icon
          @click="$bus.$emit('assignments--refresh')"
          slot="activator"
        >
          <v-progress-circular
            indeterminate
            :width="6"
            :size="18"
            v-if="$bus.progress.circular.Assignments.refresh"
          />
          <v-icon v-else>refresh</v-icon>
        </v-btn>
        <span v-if="$bus.progress.circular.Assignments.refresh">Refreshing</span>
        <span v-else>Refresh</span>
      </v-tooltip>
    </template>

    <v-tabs
      align-with-title
      show-arrows
      color="primary lighten-1"
      v-if="typeof $bus.tabs[$route.name] !== 'undefined'"
      v-model="$bus.tabs[$route.name].tab"
      slot="extension">
      <v-tab
        v-for="tab in $bus.tabs[$route.name].items"
        :key="tab">{{ tab }}</v-tab>
    </v-tabs>

  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar-content',
  computed: {
    title() {
      return this.$route.meta.title || this.$route.name || 'Application'
    }
  }
}
</script>
