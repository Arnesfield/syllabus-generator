<template>
<v-list
  two-line
  class="elevation-1 py-0"
>

  <!-- header -->

  <v-list-tile v-if="header" @click="() => {}">
    <v-list-tile-action class="thin-action">
      <v-icon color="primary lighten-1">school</v-icon>
    </v-list-tile-action>
    <v-list-tile-content>
      <v-list-tile-title>
        <strong
          class="primary--text text--lighten-1"
          v-text="title"
        />
        <span v-text="'Courses'"/>
      </v-list-tile-title>
      <v-list-tile-sub-title>
        <span>Number of {{ subtitle }}:</span>
        <strong v-text="items.length"/>
      </v-list-tile-sub-title>
    </v-list-tile-content>
  </v-list-tile>

  <template v-for="(c, i) in items">
  
    <v-divider
      :key="'divider-' + i"
      v-if="items.length"
    />

    <!-- units -->

    <v-list-tile
      @click="() => {}"
      :key="'tile-' + i"
    >
      <v-list-tile-action class="thin-action">
        <v-icon>bookmark</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title v-text="c.code"/>
        <v-list-tile-sub-title v-text="c.title"/>
      </v-list-tile-content>
      <v-list-tile-action>
        <v-tooltip top>
          <v-btn
            icon
            slot="activator"
            @click="() => {}"
          >
            <v-icon color="grey">open_in_new</v-icon>
          </v-btn>
          <span>View info</span>
        </v-tooltip>
      </v-list-tile-action>
    </v-list-tile>

  </template>

</v-list>
</template>

<script>
export default {
  name: 'related-course-list',
  props: {
    items: Array,
    title: String,
    subtitle: String,
    header: {
      type: Boolean,
      default: false
    }
  }
}
</script>
