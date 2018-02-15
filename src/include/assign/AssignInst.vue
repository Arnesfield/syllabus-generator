<template>
<div v-if="assign">
  <v-card>
    <v-card-title primary-title class="pb-0">
      <div>
        <div
          class="headline"
        >{{ getFullname(assigned()) }}</div>
        <div>{{ course().code + ' – ' + course().title }}</div>
        <v-list>
          <template v-for="(u, i) in sub()" v-if="u.user">
            <v-divider v-if="i != 0" :key="'divider-' + i"/>
            <v-list-tile :key="'tile-' + i">
              <v-list-tile-action style="min-width: 36px; width: 36px">
                <v-list-tile-action>
                  <status :item="u"/>
                </v-list-tile-action>
              </v-list-tile-action>
              <v-list-tile-title v-html="getFullname(u.user)"/>
            </v-list-tile>
          </template>
        </v-list>
      </div>
    </v-card-title>

    <v-card-actions>
      <div>
        <v-tooltip top>
          <v-btn icon slot="activator">
            <v-icon color="teal">edit</v-icon>
          </v-btn>
          <span>Edit</span>
        </v-tooltip>
      </div>
      <v-spacer/>
      <div class="px-2 pb-1 subheading">
        <span>Status</span>
        <status :item="assign"/>
      </div>
    </v-card-actions>
  </v-card>
</div>
</template>

<script>
import Status from '@/include/Status'

export default {
  name: 'assign-inst',
  components: {
    Status
  },
  props: {
    assign: {
      type: Object,
      required: true
    }
  },

  methods: {
    course() {
      return this.assign.content.course
    },
    assigned() {
      return this.assign.content.assigned
    },
    sub() {
      return this.assign.content.sub
    },
    
    getFullname(user) {
      return user.fname + ' ' + user.mname + (user.mname.length ? ' ' : '') + user.lname
    }
  }
}
</script>
