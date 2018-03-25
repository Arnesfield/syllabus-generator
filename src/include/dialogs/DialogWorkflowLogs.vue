<template>
<v-dialog
  v-model="show"
  width="460"
  :persistent="false"
  transition="fade-transition"
  scrollable
>
  <v-card v-if="subtitle">

    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      class="ma-0"
    />

    <v-card-title primary-title>
      <div>
        <div class="title mb-1">Activity</div>
        <div
          class="caption"
          v-if="subtitle"
          v-html="subtitle"
        />
      </div>
    </v-card-title>

    <v-card-text class="pa-0">
      <v-list v-if="logs.length" style="max-height: 400px; overflow-y: auto">
        <v-list-tile
          :key="i"
          @click="() => {}"
          v-for="(item, i) in logs"
          class="py-0"
        >
          <workflow-log :item="item"/>
        </v-list-tile>
      </v-list>
      <manage-no-data
        v-else
        :fetch="() => { fetch(id) }"
        :loading="loading"
        msg="No activity yet :("
      />
    </v-card-text>

    <v-card-actions>
      <v-spacer/>
      <v-btn
        flat
        color="primary"
        v-text="'Dismiss'"
        @click="show = false"
      />
    </v-card-actions>
  </v-card>
</v-dialog>  
</template>

<script>
import qs from 'qs'
import WorkflowLog from '@/include/logs/WorkflowLog'
import ManageNoData from '@/include/ManageNoData'

export default {
  name: 'dialog-workflow-logs',
  components: {
    WorkflowLog,
    ManageNoData
  },
  data: () => ({
    url: '/logs/workflow',
    id: null,
    logs: [],
    subtitle: null,
    show: false,
    loading: false
  }),

  watch: {
    show(e) {
      if (!e) {
        this.clear()
      }
    }
  },

  created() {
    this.$bus.$on('dialog--workflow-logs', this.showLogs)
  },
  beforeDestroy() {
    this.$bus.$off('dialog--workflow-logs', this.showLogs)
  },

  methods: {
    clear() {
      this.logs = []
      this.subtitle = null
      this.loading = false
    },

    showLogs(id, subtitle) {
      this.id = id
      this.subtitle = subtitle
      this.show = true
      this.fetch(id)
    },

    fetch(id) {
      if (!id) {
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        id: id
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.logs = res.data.logs
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
