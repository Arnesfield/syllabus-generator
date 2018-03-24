<template>
<v-container
  grid-list-lg
  :style="assigns.length ? null : {
    display: 'flex',
    height: 'calc(100% - 96px)'
  }"
>
  <template v-if="assigns.length && $bus.toolbar.sortByStatus">
    <template v-for="(t, i) in type" v-if="countAssigns(t.n)">
      <v-subheader
        :key="'subheader-' + i"
      >{{ t.title }}</v-subheader>
      <v-layout
        row wrap
        :key="'layout-' + i"
      >
        <v-flex
          xs12
          v-bind="{
            'sm6 md6 lg4': !listView,
            'sm12 md12 lg12': listView
          }"
          :key="'inst-' + i + '-' + j"
          v-for="(assign, j) in assigns"
          v-if="Number(assign.status) == t.n"
        >
          <workflow-inst
            class="mb-2"
            :assign='assign'
            @view="onView"
          />
        </v-flex>
      </v-layout>
    </template>
  </template>
  <template v-else-if="assigns.length && !$bus.toolbar.sortByStatus">
    <v-layout row wrap>
      <v-flex
        xs12
        v-bind="{
          'sm6 md6 lg4': !listView,
          'sm12 md12 lg12': listView
        }"
        :key="j"
        v-for="(assign, j) in assigns"
      >
        <workflow-inst
          class="mb-2"
          :key="'inst-' + j"
          :assign='assign'
          @view="onView"
        />
      </v-flex>
    </v-layout>
  </template>

  <template v-if="!assigns.length">
    <v-layout justify-center align-center>
      <manage-no-data
        class="mb-5"
        :loading="loading"
        :fetch="fetch"
      />
    </v-layout>
  </template>

  <dialog-workflow-assign ref="workflowAssign"/>
  <dialog-detailed-workflow/>

</v-container>
</template>

<script>
import WorkflowInst from '@/include/assign/WorkflowInst'
import ManageNoData from '@/include/ManageNoData'
import DialogWorkflowAssign from '@/include/dialogs/DialogWorkflowAssign'
import DialogDetailedWorkflow from '@/include/dialogs/DialogDetailedWorkflow'

export default {
  name: 'workflow',
  components: {
    WorkflowInst,
    ManageNoData,
    DialogWorkflowAssign,
    DialogDetailedWorkflow
  },
  data: () => ({
    url: '/assigns',
    assigns: [],
    loading: false,
    listView: false,
    type: [
      { title: 'Approved', n: 1 },
      { title: 'Undecided', n: 2 },
      { title: 'Not yet submitted', n: 3 },
      { title: 'Disapproved', n: 0 }
    ],
  }),
  watch: {
    loading(to, from) {
      this.$bus.progress.circular.Workflow.refresh = to
    },
    '$bus.toolbar.listView': function(e) {
      this.listView = e
    }
  },

  created() {
    this.listView = this.$bus.toolbar.listView
    this.$bus.$on('workflow--add', this.addAssign)
    this.$bus.$on('workflow--refresh', this.fetch)
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('workflow--add', this.addAssign)
    this.$bus.$off('workflow--refresh', this.fetch)
  },

  methods: {
    onView(assign, level) {
      this.$bus.$emit('dialog--detailed-workflow.show', assign, level)
    },

    addAssign() {
      if (this.$refs.workflowAssign) {
        this.$refs.workflowAssign.activate()
      }
    },

    countAssigns(n) {
      // check assigns with status n
      // return the length
      return this.assigns.filter(e => Number(e.status) == n).length
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then((res) => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        
        this.assigns = res.data.assigns
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
