<template>
  <v-toolbar color="primary" dark app :tabs="$bus.toolbar.tabs">
    <v-toolbar-side-icon @click.stop="$bus.toolbar.drawer = !$bus.toolbar.drawer"></v-toolbar-side-icon>
    <v-toolbar-title>{{ title }}</v-toolbar-title>

    <template v-if="$bus.toolbar.menu !== null">
      <v-spacer/>
      <v-menu bottom left offset-y>
        <v-btn icon slot="activator" dark>
          <v-icon>more_vert</v-icon>
        </v-btn>
        <v-list>
          <v-list-tile
            :key="i"
            v-for="(item, i) in $bus.toolbar.menu"
            @click="item.click">
            <v-list-tile-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>{{ item.title }}</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
    </template>

    <template v-if="$route.path === '/generator'">
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
      <v-menu
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
      </v-menu>
    </template>

    <v-tabs
      align-with-title
      show-arrows
      color="primary"
      v-if="$bus.toolbar.tabs"
      v-model="$bus.toolbar.tab"
      slot="extension">
      <v-tabs-slider color="accent"/>
      <v-tab
        v-for="tab in $bus.toolbar.tabItems"
        :key="tab">{{ tab }}</v-tab>
    </v-tabs>
  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar',
  props: {
    title: {
      type: String,
      default: 'Application'
    }
  }
}
</script>
