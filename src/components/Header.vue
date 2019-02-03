<template>
  <div class="header">
    <img
      class="logo"
      :src="`./static/img/header.${webp?'webp':'jpg'}`"
    >
    <div class="title">
      <h3>中国印钞造币总公司2018年度<br>“十件大事”候选事项
      </h3>
      <h4 class="subtitle">（排名不分先后）</h4>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      webp: window.__WEBP
    };
  }
};
</script>
<style scoped lang="less">
.header {
  text-align: center;
  margin-bottom: 70px;
  .title {
    h3 {
      font-weight: bold;
    }
    h4 {
      font-weight: 200;
    }
    margin-top: -150px;
    color: #fff;
    margin-bottom: 60px;
    .subtitle {
      padding-top: 10px;
    }
  }
  .logo {
    width: 100%;
    height: 100%;
  }
}
</style>
