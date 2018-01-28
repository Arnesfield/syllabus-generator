<template>
  <v-toolbar color="primary" dark app :tabs="$bus.tabs">
    <v-toolbar-side-icon @click.stop="$bus.drawer = !$bus.drawer"></v-toolbar-side-icon>
    <v-toolbar-title>{{ title }}</v-toolbar-title>

    <template v-if="$bus.menu !== null">
      <v-spacer/>
      <v-menu bottom left offset-y>
        <v-btn icon slot="activator" dark>
          <v-icon>more_vert</v-icon>
        </v-btn>
        <v-list>
          <v-list-tile
            :key="i"
            v-for="(item, i) in $bus.menu"
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
      v-if="$bus.tabs"
      v-model="$bus.tab"
      slot="extension">
      <v-tabs-slider color="accent"/>
      <v-tab
        v-for="tab in $bus.tabItems"
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
