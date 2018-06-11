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
  class="grey lighten-4"
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

  <div v-if="dItems && dItems.length">
    <v-subheader>{{ dItems.length }} Selected</v-subheader>
    <manage-outcome-inst
      :key="i"
      v-for="(item, i) in dItems"
      v-model="dItems[i]"
      report
      closable
      class="pa-2 mx-3 mb-3"
      @close="() => { closeItem(i) }"
    />
    <div style="height: 80px"></div>
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
  },

  data: () => ({
    dItems: []
  }),

  watch: {
    items(e) {
      this.dItems = e
    },
    dItems: {
      deep: true,
      handler(e) {
        this.setNavVisibility()
        this.$emit('update:items', e)
      }
    }
  },

  created() {
    this.dItems = this.items
    this.setNavVisibility()
  },

  methods: {
    setNavVisibility() {
      // hide nav when there are no items
      if (this.dItems && this.dItems.length) {
        this.$bus.toolbar.outcomes.model = null
      } else {
        this.$bus.toolbar.outcomes.model = false
      }
    },

    closeItem(i) {
      this.dItems.splice(i, 1)
    }
  }
}
</script>
