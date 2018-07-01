<template>
<v-card
  hover
  :href="'/#/syllabus/view/' + course.id + '/' + item.id"
  target="_blank"
>
  <v-card-title>
    <div>
      <div
        class="title"
        v-text="'v' + item.version"
      />
      <div
        class=""
        v-text="course.code"
      />
      <div
        class="grey--text caption"
        v-text="course.title"
      />
    </div>
  </v-card-title>

  <v-card-text class="pa-0">

    <!-- assigned to -->
    <v-layout row wrap align-center class="px-2">
      <span class="ml-3">
        <icon-img
          :item="c.facultyInCharge"
          color="primary lighten-1"
          size="32"
          caption
        />
      </span>
      <v-subheader class="py-0 pl-1 ml-2">
        <div>
          <div>
            <span v-text="$wrap.fullname(c.facultyInCharge)"/>
            <add-me :id="c.facultyInCharge.id"/>
          </div>
          <div class="caption">
            <template
              v-if="c.facultyInCharge.title"
            >{{ c.facultyInCharge.title }}&nbsp;</template>
            <template>(Faculty-In-Charge)</template>
          </div>
        </div>
      </v-subheader>
    </v-layout>

    <div class="px-3 pt-2 pb-3 caption">

      <table style="border-collapse: collapse">
        <tr>
          <td>
            <span class="pr-1 grey--text">Approved by:</span>
          </td>
          <td>
            <template v-for="(p, i) in u = filterDuplicateUsers(c.approvedBy)">
              <span
                :key="'name-' + i"
              >{{ $wrap.fullname(p.user) }}</span><template
                v-if="u.length-1 !== i"
              >,&nbsp;</template>
            </template>
          </td>
        </tr>

        <tr>
          <td>
            <span class="pr-1 grey--text">Last Updated:</span>
          </td>
          <td>
            <span v-text="$moment.unix(item.updated_at).format('MMMM DD, YYYY h:mmA')"></span>
          </td>
        </tr>
      </table>

    </div>

  </v-card-text>
</v-card>
</template>

<script>
import find from 'lodash/find'
import AddMe from '@/include/AddMe'
import IconImg from '@/include/IconImg'

export default {
  name: 'selectable-syllabus-view',
  components: {
    AddMe,
    IconImg
  },
  props: {
    item: Object
  },
  computed: {
    c() {
      return this.item.content
    },
    course() {
      return this.c.course
    }
  },

  methods: {
    filterDuplicateUsers(arr) {
      return arr.reduce((filtered, users) => {
        // check if user exists in filtered
        // if not, add it
        users.forEach(user => {
          if (!find(filtered, user)) {
            filtered.push(user)
          }
        })
        return filtered
      }, [])
    }
  }
}
</script>
