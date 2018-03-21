<template>
<v-card v-if="assign">
  <v-card-title primary-title class="pb-0">
    <div class="full-width">
      <div
        class="headline"
      >{{ $wrap.fullname(assigned()) }}</div>
      <div class="subheading">{{ course().code + ' – ' + course().title }}</div>
      <div class="grey--text">Assigned by: {{ $wrap.fullname(assign.created_by) }}</div>
      <v-list>
        <template v-for="(u, i) in sub()" v-if="u.user">
          <!-- <v-divider v-if="i != 0" :key="'divider-' + i"/> -->
          <v-list-tile :key="'tile-' + i">
            <v-list-tile-action style="min-width: 36px; width: 36px">
              <v-list-tile-action>
                <status :item="u"/>
              </v-list-tile-action>
            </v-list-tile-action>
            <v-list-tile-title v-html="$wrap.fullname(u.user)"/>
          </v-list-tile>
        </template>
      </v-list>
    </div>
  </v-card-title>

  <v-card-actions>
    <div>
      <v-tooltip top>
        <v-btn
          icon
          slot="activator"
          @click="$emit('view', assign)"
        >
          <v-icon color="grey">info</v-icon>
        </v-btn>
        <span>
          <div>Assigned at: {{ $wrap.datetime(assign.created_at, true, false) }}</div>
          <div
            v-if="assign.created_at !== assign.updated_at"
          >Last updated at: {{ $wrap.datetime(assign.updated_at, true, false) }}</div>
        </span>
      </v-tooltip>
      <v-tooltip top v-if="$bus.session.user.id == assign.created_by.id">
        <v-btn icon slot="activator">
          <v-icon color="grey">edit</v-icon>
        </v-btn>
        <span>Edit</span>
      </v-tooltip>
      <v-tooltip top v-if="$bus.session.user.id == assigned().id">
        <v-btn icon slot="activator" @click="createSyllabus">
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
    </div>
    <v-spacer/>
    <div class="px-2 pb-1 subheading">
      <span>Status</span>
      <status :item="assign"/>
    </div>
  </v-card-actions>
</v-card>
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
    createSyllabus() {
      this.$router.push('/generator/' + this.assign.id)
    },
    course() {
      return this.assign.content.course
    },
    assigned() {
      return this.assign.content.assigned
    },
    sub() {
      return this.assign.content.sub
    }
  }
}
</script>
