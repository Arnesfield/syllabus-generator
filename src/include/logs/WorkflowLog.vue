<template>
<v-layout
  align-center
  class="pa-2"
>
  <icon-img
    :item="item"
    color="primary lighten-1"
    size="32"
    caption
  />
  <div class="pl-3">
    <div
      class="subheader pl-0"
      style="height: 20px"
    >{{ $wrap.fullname(item) }}&nbsp;
      <add-me :id="item.user_id"/>
    </div>
    <div
      class="caption grey--text"
      v-html="item.content"
    />
  </div>
  <v-spacer/>
  <div class="text-xs-right caption grey--text">
    <template v-if="displayRelative">
      <div v-text="$moment.unix(item.created_at).fromNow()"/>
      <br/>
    </template>
    <template v-else>
      <div v-text="$moment.unix(item.created_at).format('h:mmA')"/>
      <div v-text="$moment.unix(item.created_at).format('MM/DD/YY')"/>
    </template>
  </div>
</v-layout>
</template>

<script>
import AddMe from '@/include/AddMe'
import IconImg from '@/include/IconImg'

export default {
  name: 'workflow-log',
  components: {
    AddMe,
    IconImg
  },
  props: {
    item: Object
  },
  computed: {
    displayRelative() {
      let start = this.$moment.unix(this.item.created_at)
      let end = this.$moment()
      return end.diff(start, 'hours') <= 24
    }
  }
}
</script>
