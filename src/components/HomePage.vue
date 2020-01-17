<template>
  <div class="wrapper">
    <div class="content">
      <p class="title">
        中国印钞造币总公司2019年度
        <br />“十件大事”评选活动
      </p>
      <p
        class="desc"
      >刚刚过去的2018年，不忘初心、逐梦前行的祖国和人民都收获满满、幸福满满。肩负为国造币神圣使命的中钞人在总公司董事会、党委经理部的领导下，围绕“转型发展”这一核心使命，凝心聚力、砥砺前行，取得了靓丽的业绩！</p>
      <p
        class="desc"
      >为向大家全面展示2018年中国印钞造币行业的新发展、新成就、新气象，让大家更加了解中国印钞造币行业、支持中国印钞造币事业，今天小印请您当评委，邀您共同参与中国印钞造币行业2018年“十件大事”评选活动！积极投票还能参加抽奖哦！请在13个选项中选出你认为的“十件大事”。</p>
      <p
        class="desc"
      >2月底我们将组织印钞造币行业内部专家投票，并以专家投票结果作为十件大事确认事项。参与者选出的十件大事与最终结果完全一致即可参加抽奖活动，中奖名单奖将通过“中国印钞造币”微信公众号公布。</p>
      <p class="desc" style="text-indent:0;">活动规则</p>
      <p class="desc">（一）每个微信号参与者限投一次，一次限选10件候选大事，投票后填写详细联系方式（如填写信息不完整，视为自动放弃获奖资格）。</p>
      <p class="desc">（二）为感谢大家的积极参与，本次活动将根据参与者投票的命中率进行抽奖（共设一、二、三等奖）：</p>
      <p
        class="desc"
      >1、2月底我们将组织印钞造币行业内部专家投票，并以专家投票结果作为十件大事确认事项。参与者选出的十件大事与最终结果完全一致即可参加抽奖活动，由中国印钞造币总公司组织抽奖，从满足条件的参与者中抽取600名一、二、三等奖中奖者。</p>
      <p class="desc">2、如与“十件大事”的最终评选结果完全重合的投票人数不足600名，则按评选命中率从高到低依次选足抽奖人员。</p>
      <p class="desc">3、参与抽奖人员只与投票准确率有关，与投票先后无关。</p>
      <div class="margin-top-20 time">活动时间：{{year}}年{{sport.timeRange}}</div>
      <div class="btn-wrapper margin-top-60">
        <div class="weui-btn weui-btn_default" @click="jump('home')">开始投票</div>
      </div>
    </div>
    <toast v-model="toast.show">{{ toast.msg }}</toast>
    <div class="canvas" id="home"></div>
    <x-footer color="#f3d713" />
  </div>
</template>
<script>
import particles from "particles.js";
import particlesSetting from "../js/particlesSetting";

import XFooter from "./Footer";
import { XButton, Toast } from "vux";
import { mapState } from "vuex";
import * as db from "../js/db";
import moment from "dayjs";

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
    ...mapState(["cdnUrl", "userInfo"]),
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
    },
    isSportEnd() {
      return moment().format("YYYY-MM-DD HH:mm:ss") > this.sport.endDate;
    }
  },
  watch: {
    "userInfo.openid"(val) {
      if (!val) {
        return;
      }
      this.getStep();
    }
  },
  methods: {
    jump(router) {
      var video = document.querySelector("#mainvideo");
      // video.play();
      // video.pause();
      this.$router.push(router);
    },
    async getStep() {
      if (this.isSportEnd) {
        this.$router.push("message");
        return;
      }
      if (!this.userInfo.openid) {
        return;
      }

      let { rows } = await db.getCbpmVoteMain(this.userInfo.openid);
      if (rows > 0) {
        this.$router.push("/info");
        return;
      }
    }
  },
  mounted() {
    particlesJS("home", particlesSetting);
    document.title = this.sport.name;
    this.getStep();
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
