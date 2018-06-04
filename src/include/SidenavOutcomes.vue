<template>
<v-navigation-drawer
  app
  fixed
  :mini-variant="false"
  :clipped="true"
  width="380"
  v-model="$bus.toolbar.outcomes.model"
  right
  style="padding-bottom: 0"
>

  <v-toolbar
    flat
    dark
    color="accent"
  >
    <v-toolbar-title v-html="'Outcomes'"/>
    <v-spacer/>
    <btn-refresh tip="bottom"/>
    <v-tooltip bottom>
      <v-btn
        icon
        slot="activator"
        @click="$bus.toolbar.outcomes.model = false"
      >
        <v-icon>chevron_right</v-icon>
      </v-btn>
      <span>Hide</span>
    </v-tooltip>
  </v-toolbar>

  <div v-if="items && items.length">
    <manage-outcome-inst
      :key="i"
      v-for="(item, i) in items"
      v-model="items[i]"
      report
      class="pa-2 ma-3"
    />
  </div>
  <v-container
    fluid
    v-else
    class="caption grey--text text-xs-center"
    v-text="'Please select outcomes to start.'"
  />

</v-navigation-drawer>
</template>

<script>
import BtnRefresh from '@/include/BtnRefresh'
import ManageOutcomeInst from '@/include/ManageOutcomeInst'

export default {
  name: 'sidenav-outcomes',
  components: {
    BtnRefresh,
    ManageOutcomeInst
  },
  props: {
    items: Array
  }
}
</script>
