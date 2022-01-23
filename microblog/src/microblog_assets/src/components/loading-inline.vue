<template>
  <div class="inline-loading">
    <div v-show="isShow" class="loading-text">
      加载中...
      <span class="weui-primary-loading weui-primary-loading_brand" >
        <span class="weui-primary-loading__dot"></span>
      </span>
    </div>  
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
.loading-text{
  color: var(--weui-FG-2);
  font-size:14px;
}
</style>