<template>
<v-dialog
  v-model="show"
  :persistent="true"
  transition="fade-transition"
  width="640"
  scrollable
>
  <v-card v-if="item">

    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      background-color="primary lighten-1"
      class="ma-0 primary lighten-1"
    />

    <v-layout
      class="primary lighten-1"
      style="min-height: 48px"
    >
      <v-btn
        dark
        icon
        :disabled="loading"
        @click.native="show = false"
        @keypress.enter="show = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-tabs
        dark
        show-arrows
        v-model="tabs"
        color="primary lighten-1"
        style="width: calc(100% - 64px)"
      >
        <v-tab :disabled="loading">Info</v-tab>
        <!-- loop levels -->
        <template v-for="level in item.level.length">
          <v-tab
            :key="level"
            :disabled="loading"
          >Lvl{{ level }}</v-tab>
        </template>
      </v-tabs>
    </v-layout>

    <v-card-text>
      <v-form ref="form" v-model="form">
        <v-tabs-items v-model="tabs">
          <v-tab-item>
            <workflow-info v-model="item"/>
          </v-tab-item>
          <!-- loop levels -->
        <template v-for="(level, i) in item.level">
          <v-tab-item :key="i">
            <workflow-level
              :index="i"
              v-model="item.level[i]"
            />
          </v-tab-item>
        </template>
        </v-tabs-items>
      </v-form>
    </v-card-text>

    <v-divider/>
    <v-card-actions>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        v-if="tabs == 0"
        @click="show = false"
        @keypress.enter="show = false"
        v-text="'Cancel'"
      />
      <v-btn
        flat
        tabindex="0"
        color="primary"
        :disabled="loading"
        @click="tabs = 0"
        v-if="Number(tabs) > 0"
        @keypress.enter="tabs = 0"
        v-text="'Info'"
      />
      <v-spacer/>
      <v-tooltip
        top
        class="mx-0"
        v-if="tabs > 0"
      >
        <v-btn
          flat
          icon
          tabindex="0"
          slot="activator"
          :disabled="loading"
          @click="tabs = tabs-1"
          @keypress.enter="tabs = tabs-1"
        >
          <v-icon>keyboard_arrow_left</v-icon>
        </v-btn>
        <span>Previous</span>
      </v-tooltip>
      <v-tooltip
        top
        class="mx-0"
        v-if="Number(tabs) < item.level.length"
      >
        <v-btn
          flat
          icon
          tabindex="0"
          slot="activator"
          :disabled="loading"
          @click="tabs = Number(tabs)+1"
          @keypress.enter="tabs = Number(tabs)+1"
        >
          <v-icon>keyboard_arrow_right</v-icon>
        </v-btn>
        <span>Next</span>
      </v-tooltip>
      <v-tooltip top>
        <v-btn
          flat
          icon
          tabindex="0"
          color="primary"
          slot="activator"
          :disabled="loading"
          @click="submit"
          @keypress.enter="submit"
        >
          <v-icon>done</v-icon>
        </v-btn>
        <span>Finish and save</span>
      </v-tooltip>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import WorkflowInfo from '@/include/assign/WorkflowInfo'
import WorkflowLevel from '@/include/assign/WorkflowLevel'

export default {
  name: 'dialog-workflow-assign',
  components: {
    WorkflowInfo,
    WorkflowLevel
  },
  data: () => ({
    show: false,
    item: null,
    tabs: 0,
    mode: 'add',
    loading: false,
    form: false
  }),
  watch: {
    show(e) {
      if (!e) {
        // clear data
        this.clear()
      }
    },
    item: {
      deep: true,
      handler(to, from) {
        
      }
    }
  },
  methods: {
    clear() {
      this.tabs = 0
      this.item = null
      this.loading = false
    },

    activate(item, options) {
      if (typeof options !== 'undefined' && options !== null) {
        this.mode = options.mode || 'add'
      }

      if (typeof item === 'undefined' || item === null) {
        // create item instead
        item = {
          assign: null,
          course: null,
          level: [{}, {}, {}]
        }
      }
      this.show = true
      this.item = item
    },

    submit() {

    }
  }
}
</script>
