<template>
<v-container
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
      <v-list
        :key="'list-' + i"
        three-line
        class="elevation-1 py-0 mb-3"
      >
        <template
          v-for="(assign, i) in assigns"
          v-if="Number(assign.status) == t.n"
        >
          <workflow-inst
            :key="'inst-' + i"
            :assign='assign'
            @view="onView(assign)"
          />
          <v-divider :key="'divider-' + i"/>
        </template>
      </v-list>
    </template>
  </template>
  <template v-else-if="assigns.length && !$bus.toolbar.sortByStatus">
    <v-list
      three-line
      class="elevation-1 py-0 mb-3"
    >
      <template v-for="(assign, i) in assigns">
        <workflow-inst
          :key="'inst-' + i"
          :assign='assign'
          @view="onView(assign)"
        />
        <v-divider :key="'divider-' + i"/>
      </template>
    </v-list>
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

  <dialog-add-assign/>
  <dialog-detailed-workflow/>

</v-container>
</template>

<script>
import WorkflowInst from '@/include/assign/WorkflowInst'
import ManageNoData from '@/include/ManageNoData'
import DialogAddAssign from '@/include/dialogs/DialogAddAssign'
import DialogDetailedWorkflow from '@/include/dialogs/DialogDetailedWorkflow'

export default {
  name: 'workflow',
  components: {
    WorkflowInst,
    ManageNoData,
    DialogAddAssign,
    DialogDetailedWorkflow
  },
  data: () => ({
    url: '/assigns',
    assigns: [],
    loading: false,
    size: 'lg',
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
    }
  },

  created() {
    this.$bus.$on('workflow--add', this.addAssign)
    this.$bus.$on('workflow--refresh', this.fetch)
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('workflow--add', this.addAssign)
    this.$bus.$off('workflow--refresh', this.fetch)
  },

  methods: {
    onView(assign) {
      this.$bus.$emit('dialog--detailed-workflow.show', assign)
    },

    addAssign() {
      this.$bus.dialog.Assign.add = true
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
