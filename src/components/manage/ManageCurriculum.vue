<template>
<v-container
  fluid
  :style="curriculum.length ? null : {
    display: 'flex',
    height: 'calc(100% - 96px)'
  }"
>

  <template v-if="curriculum.length">
    <v-list
      two-line
      class="elevation-1"
    >
      <template v-for="(item, i) in curriculum">
        <v-list-tile
          :key="'tile-' + i"
          @click="editItem(item)"
          @keypress.enter="editItem(item)"
          tabindex="0"
        >

          <v-list-tile-action class="thin-48">
            <status :item="item"/>
          </v-list-tile-action>

          <v-layout align-center>
            <v-list-tile-content>
              <v-list-tile-title v-text="item.label"/>
              <v-list-tile-sub-title
              >Number of items:
                <strong v-text="item.content.length"/>
              </v-list-tile-sub-title>
            </v-list-tile-content>

            <v-layout
              class="caption grey--text"
              align-center
            >
              <div class="full-width text-xs-right">
                <template v-if="displayRelative(item.updated_at)">
                  <div v-text="$moment.unix(item.updated_at).fromNow()"/>
                </template>
                <template v-else>
                  <div v-text="$moment.unix(item.updated_at).format('h:mmA')"/>
                  <div v-text="$moment.unix(item.updated_at).format('MM/DD/YY')"/>
                </template>
              </div>
            </v-layout>
          </v-layout>

        </v-list-tile>
        <v-divider
          :key="'divider-' + i"
          v-if="curriculum.length-1 != i"
        />
      </template>
    </v-list>
  </template>

  <v-layout
    v-else
    justify-center
    align-center
  >
    <manage-no-data
      class="mb-5"
      msg="No curriculum yet :("
      :loading="loading"
      :fetch="fetch"
    />
  </v-layout>

  <dialog-manage-curriculum ref="dialogManage"/>

</v-container>
</template>

<script>
import Status from '@/include/Status'
import ManageNoData from '@/include/ManageNoData'
import DialogManageCurriculum from '@/include/dialogs/DialogManageCurriculum'

export default {
  name: 'manage-curriculum',
  components: {
    Status,
    ManageNoData,
    DialogManageCurriculum
  },
  data: () => ({
    url: '/curriculum',
    curriculum: [],
    loading: false
  }),
  watch: {
    loading(e) {
      this.$bus.refresh(e)
    }
  },

  created() {
    this.$bus.$on('curriculum--add', this.addItem)
    this.$bus.$on('manage--curriculum.update', this.fetch)
    this.$bus.$on('refresh--btn', this.fetch)
    this.fetch()
  },
  beforeDestroy() {
    this.$bus.$off('curriculum--add', this.addItem)
    this.$bus.$off('manage--curriculum.update', this.fetch)
    this.$bus.$off('refresh--btn', this.fetch)
  },

  methods: {
    editItem(item) {
      if (this.$refs.dialogManage) {
        this.$refs.dialogManage.editItem(item)
      }
    },

    addItem() {
      if (this.$refs.dialogManage) {
        this.$refs.dialogManage.addItem()
      }
    },

    displayRelative(time) {
      let start = this.$moment.unix(time)
      let end = this.$moment()
      return end.diff(start, 'hours') <= 24
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then(res => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.curriculum = res.data.curriculum
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
