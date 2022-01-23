<template>
  <div class="inline-loading">
    <span class="weui-primary-loading weui-primary-loading_transparent" v-show="isShow">
      <span class="weui-primary-loading__dot"></span>
    </span>
  </div>
</template>

<script>
export default {
  props:['isShow']
}
</script>

<style>
.inline-loading{
  text-align: center;
}
</style>