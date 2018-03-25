<template>
<v-card class="mb-2">
  <v-card-title class="pr-2 pt-2">
    <icon-img
      caption
      size="32"
      :item="item.user"
      color="primary"
    />
    <div class="subheader">
      <div>
        <div class="subheading black--text">
          <template>{{ $wrap.fullname(item.user) }}</template>
          <add-me :id="item.user.id"/>
        </div>
        <div
          class="caption grey--text"
          v-text="$moment.unix(item.created_at).format('MM/DD/YY h:mmA')"
        />
      </div>
    </div>

    <template v-if="$bus.session.user.id == item.user.id">

      <v-spacer/>

      <v-menu left offset-y min-width="128">
        <v-btn
          icon
          slot="activator"
        >
          <v-icon color="grey">more_vert</v-icon>
        </v-btn>
        <v-list>
          <v-list-tile @click="$emit('delete')">
            <v-list-tile-action class="thinner-action">
              <v-icon>delete</v-icon>
            </v-list-tile-action>
            <v-list-tile-title v-text="'Delete'"/>
          </v-list-tile>
        </v-list>
      </v-menu>

    </template>
    
  </v-card-title>
  <v-card-text
    class="pt-0"
    v-text="item.comment"
  />
</v-card>
</template>

<script>
import AddMe from '@/include/AddMe'
import IconImg from '@/include/IconImg'

export default {
  name: 'comment-inst',
  components: {
    AddMe,
    IconImg
  },
  props: {
    item: Object
  }
}
</script>
