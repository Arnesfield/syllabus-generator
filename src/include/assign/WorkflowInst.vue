<template>
<v-card class="pa-2">

  <v-layout>

    <div
      style="width: 24px"
      :class="{ [sideColor]: true }"
    />

    <div class="full-width">
      <v-card-title primary-title class="pb-1">
        <div>
          <div
            class="title mb-1"
            v-text="course().code"
          />
          <div
            class="grey--text caption"
            v-text="course().title"
          />
          <div
            class="grey--text caption"
          >Assigned by:
            <strong v-text="$wrap.fullname(createdBy())"/>
          </div>
        </div>
        <v-spacer/>
        <div class="caption grey--text text-xs-right">
          <div v-text="$moment.unix(assign.updated_at).format('h:mmA')"/>
          <div v-text="$moment.unix(assign.updated_at).format('MM/DD/YY')"/>
          <br/>
        </div>
      </v-card-title>

      <!-- <v-divider/> -->

      <v-card-text class="px-2 pb-2 pt-2">

        <!-- assigned to -->
        <v-layout row wrap align-center class="pb-2">
          <span class="ml-3">
            <icon-img
              :item="assigned()"
              color="primary lighten-1"
              size="32"
              caption
            />
          </span>
          <v-subheader class="py-0 pl-1 ml-2">
            <div>
              <div>
                <span v-text="$wrap.fullname(assigned())"/>
                <add-me :id="assigned().id"/>
                <!-- <strong class="caption grey--text" v-text="'(assigned)'"/> -->
              </div>
              <div class="caption">
                <template
                  v-if="assigned().title"
                >{{ assigned().title }}&nbsp;</template>
                <template>(Faculty-In-Charge)</template>
              </div>
            </div>
          </v-subheader>
        </v-layout>

        <!-- remarks -->
        <remarks-inst
          :remarks="shortRemarks()"
          class="mx-2 mb-3"
        />

        <!-- levels -->
        <v-layout
          row wrap align-center
          class="pb-2"
        >
          <div
            class="px-3 caption grey--text text--darken-1"
          >Level {{ levels() }}</div>
        </v-layout>

      </v-card-text>

      <v-divider/>

      <v-card-actions>
        <status :item="assign"/>
        <v-tooltip top>
          <v-btn
            icon
            slot="activator"
            @click="$emit('view', assign)"
          >
            <v-icon color="grey">info</v-icon>
          </v-btn>
          <span>View detailed</span>
        </v-tooltip>

        <!-- <v-tooltip
          top
          v-if="$bus.session.user.id == createdBy().id"
        >
          <v-btn icon slot="activator">
            <v-icon color="grey">edit</v-icon>
          </v-btn>
          <span>Edit</span>
        </v-tooltip> -->

        <v-tooltip
          top
          v-if="
            $bus.session.user.id == assigned().id &&
            (Number(assign.status) == 0 || Number(assign.status) == 3)
          "
        >
          <v-btn icon slot="activator" :to="'/generator/' + assign.id">
            <v-icon color="grey">arrow_forward</v-icon>
          </v-btn>
          <span>Create Syllabus</span>
        </v-tooltip>

        <v-tooltip top v-if="Number(assign.status) != 3">
          <v-btn icon slot="activator" :to="'/syllabus/' + assign.id">
            <v-icon color="grey">visibility</v-icon>
          </v-btn>
          <span>View Syllabus</span>
        </v-tooltip>

      </v-card-actions>
    </div>

  </v-layout>
</v-card>
</template>

<script>
import truncate from 'lodash/truncate'
import AddMe from '@/include/AddMe'
import Status from '@/include/Status'
import IconImg from '@/include/IconImg'
import RemarksInst from '@/include/RemarksInst'

export default {
  name: 'workflow-inst',
  components: {
    AddMe,
    Status,
    IconImg,
    RemarksInst
  },
  props: {
    assign: {
      type: Object,
      required: true
    }
  },
  computed: {
    sideColor() {
      switch (Number(this.assign.status)) {
        case 0: return 'error'
        case 1: return 'success'
        case 2: return 'accent'
        case 3: return 'grey lighten-1'
      }
      return null
    }
  },

  methods: {
    course() {
      return this.assign.content.course
    },
    createdBy() {
      return this.assign.created_by
    },
    assigned() {
      return this.assign.content.assigned.user
    },
    remarks() {
      return this.assign.content.remarks || null
    },
    shortRemarks() {
      let remarks = this.remarks()
      return !remarks ? null : truncate(remarks, {
        length: 96,
        separator: /,? +/
      })
    },
    levels() {
      let levels = this.assign.content.levels
      let myLevel = this.$bus.checkLevels(levels, 1)
      return myLevel + ' of ' + levels.length
    }
  }
}
</script>
