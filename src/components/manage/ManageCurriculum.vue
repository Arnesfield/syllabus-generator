<template>
<v-container fluid>
  
  <v-text-field
    solo
    label="Search curriculum"
    prepend-icon="search"
    :append-icon="search ? 'close' : undefined"
    :append-icon-cb="() => { search ? search = null : null }"
    class="mb-2"
    ref="searchbar"
    v-model="search"
  />

  <template v-if="latest">
    <v-subheader>Latest</v-subheader>

    <v-list
      two-line
      class="elevation-1 py-0"
    >
      <v-list-tile
        @click="editItem(latest)"
        @keypress.enter="editItem(latest)"
        tabindex="0"
        ripple
      >
        <v-list-tile-action class="thin-48">
          <status
            :item="latest"
            :msg="statusMsg"
          />
        </v-list-tile-action>

        <v-layout align-center>
          <v-list-tile-content>
            <v-list-tile-title>
              <span
                class="warning--text"
                v-text="latest.label"
              />
              <span class="caption warning--text">(latest)</span>
            </v-list-tile-title>
            <v-list-tile-sub-title class="warning--text">Latest curriculum. Number of items:
              <strong v-text="latest.content.length"/>
            </v-list-tile-sub-title>
          </v-list-tile-content>
          <v-layout
            class="caption grey--text"
            align-center
          >
            <div class="full-width text-xs-right">
              <template v-if="displayRelative(latest.updated_at)">
                <div v-text="$moment.unix(latest.updated_at).fromNow()"/>
              </template>
              <template v-else>
                <div v-text="$moment.unix(latest.updated_at).format('h:mmA')"/>
                <div v-text="$moment.unix(latest.updated_at).format('MM/DD/YY')"/>
              </template>
            </div>
          </v-layout>
        </v-layout>

      </v-list-tile>
    </v-list>

    <v-divider class="mt-3 mb-2"/>
  </template>

  <template v-if="curriculum.length">
    <v-subheader>List</v-subheader>
    <v-list
      two-line
      class="elevation-1 py-0"
    >
      <template v-for="(item, i) in curriculum">
        <v-list-tile
          :key="'tile-' + i"
          @click="editItem(item)"
          @keypress.enter="editItem(item)"
          tabindex="0"
          ripple
        >

          <v-list-tile-action class="thin-48">
            <status
              :item="item"
              :msg="statusMsg"
            />
          </v-list-tile-action>

          <v-layout align-center>
            <v-list-tile-content>
              <v-list-tile-title>
                <span
                  :class="{ 'warning--text': Boolean(Number(item.latest)) }"
                  v-text="item.label"
                />
                <span
                  class="caption warning--text"
                  v-if="Boolean(Number(item.latest))"
                  v-text="'(latest)'"
                />
              </v-list-tile-title>
              <v-list-tile-sub-title
                :class="{ 'warning--text': Boolean(Number(item.latest)) }"
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
      msg="No curriculum to show :("
      :loading="loading"
      :fetch="fetch"
    />
  </v-layout>

  <dialog-manage-curriculum ref="dialogManage"/>

</v-container>
</template>

<script>
import qs from 'qs'
import find from 'lodash/find'
import debounce from 'lodash/debounce'
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
    loading: false,
    statusMsg: {
      0: 'Deactivated',
      1: 'Activated',
      2: 'Undecided',
      3: 'Not yet submitted'
    },
    limit: 100,
    offset: 1,

    search: null
  }),
  watch: {
    loading(e) {
      this.$bus.refresh(e)
    },
    search(e) {
      this.fetch()
    }
  },
  computed: {
    latest() {
      if (this.curriculum.length === 0) {
        return null
      }
      return find(this.curriculum, { latest: '1' })
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

    fetch: debounce(function() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: this.search,
        limit: this.limit,
        offset: this.offset
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.curriculum = res.data.curriculum
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }, 300)
  }
}
</script>
