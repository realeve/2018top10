<template>
  <div class="wrapper">
    <div class="content">
      <p class="title">
        中国印钞造币总公司2018年度<br>“十件大事”评选活动
      </p>
      <p class="desc">刚刚过去的2018年，不忘初心、逐梦前行的祖国和人民都收获满满、幸福满满。肩负为国造币神圣使命的中钞人在总公司董事会、党委经理部的领导下，围绕“转型发展”这一核心使命，凝心聚力、砥砺前行，取得了靓丽的业绩！</p>
      <p class="desc">
        为向大家全面展示2018年中国印钞造币行业的新发展、新成就、新气象，让大家更加了解中国印钞造币行业、支持中国印钞造币事业，今天小印请您当评委，邀您共同参与中国印钞造币行业2018年“十件大事”评选活动！积极投票还能参加抽奖哦！请在13个选项中选出你认为的“十件大事”。
      </p>
      <p class="desc">
        2月底我们将组织印钞造币行业内部专家投票，并以专家投票结果作为十件大事确认事项。参与者选出的十件大事与最终结果完全一致即可参加抽奖活动，中奖名单奖将通过“中国印钞造币”微信公众号公布。
      </p>
      <div class="margin-top-20 time">
        活动时间：{{year}}年{{sport.timeRange}}
      </div>
      <div class="btn-wrapper margin-top-60">
        <div
          class="weui-btn weui-btn_default"
          @click="jump('home')"
        >开始投票</div>
      </div>
    </div>
    <toast v-model="toast.show">{{ toast.msg }}</toast>
    <div
      class="canvas"
      id="home"
    ></div>
    <x-footer color="#f3d713" />
  </div>
</template>
<script>
import particles from "particles.js";
import particlesSetting from "../js/particlesSetting";

import XFooter from "./Footer";
import { XButton, Toast } from "vux";
import { mapState } from "vuex";

export default {
  components: {
    XButton,
    Toast,
    XFooter
  },
  data() {
    return {
      toast: {
        show: false,
        msg: ""
      }
    };
  },
  computed: {
    ...mapState(["cdnUrl"]),
    year() {
      let date = new Date();
      return date.getFullYear();
    },
    sport: {
      get() {
        return this.$store.state.sport;
      },
      set(val) {
        this.$store.commit("setSport", val);
      }
    }
  },
  methods: {
    jump(router) {
      var video = document.querySelector("#mainvideo");
      // video.play();
      // video.pause();
      this.$router.push(router);
    }
  },
  mounted() {
    particlesJS("home", particlesSetting);
    document.title = this.sport.name;
  }
};
</script>
<style lang="less" scoped>
.wrapper {
  display: flex;
  align-items: center;
  flex-direction: column;
  min-height: 100vh;
  background-color: #e33e3e;
}

.content {
  flex: 1;
  display: flex;
  align-items: center;
  flex-direction: column;
  font-size: 13pt;
  color: #fff;
  width: 100%;
  justify-content: center;
  margin-bottom: 20px;
  .title {
    font-size: 20pt;
    text-align: center;
    margin-top: 20px;
  }
  .desc {
    padding: 15px;
    text-indent: 2em;
  }
  .time {
    font-size: 11pt;
  }
  .btn-wrapper {
    width: 80%;
    font-size: 10pt;
    p {
      padding-bottom: 10px;
    }
  }
}

.canvas {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.weui-btn_default {
  background: transparent;
  color: #fafafa;
}

.weui-btn:after {
  border-color: rgba(255, 255, 255, 0.5);
}

.slogan {
  padding-top: 15px;
  font-size: 15pt;
  color: #f3d713;
}
</style>
