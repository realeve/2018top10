<template>
  <div class="wrapper">
    <div class="content">
      <p class="title">
        中国印钞造币总公司2020年度
        <br />“十件大事”评选活动
      </p>
      <p class="desc">
        回望2020年，不忘初心、逐梦前行的祖国和人民都收获满满、幸福满满。肩负为国造币神圣使命的中钞人在总公司董事会、党委经理部的领导下，围绕“转型发展”这一核心使命，凝心聚力、砥砺前行，取得了靓丽的业绩！
      </p>
      <p class="desc">
        为向大家全面展示2020年中国印钞造币行业的新发展、新成就、新气象，让大家更加了解中国印钞造币行业、支持中国印钞造币事业，今天小印请您当评委，邀您共同参与中国印钞造币行业2020年“十件大事”评选活动！请在12个选项中选出你认为的“十件大事”。
      </p>
      <div class="btn-wrapper margin-top-60">
        <div class="weui-btn weui-btn_default" @click="jump('home')">
          开始投票
        </div>
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
    XFooter,
  },
  data() {
    return {
      toast: {
        show: false,
        msg: "",
      },
      isVoted: false,
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
      },
    },
    isSportEnd() {
      return moment().format("YYYY-MM-DD HH:mm:ss") > this.sport.endDate;
    },
  },
  watch: {
    "userInfo.openid"(val) {
      if (!val) {
        return;
      }
      this.getStep();
    },
  },
  methods: {
    jump(router) {
      // var video = document.querySelector("#mainvideo");
      // video.play();
      // video.pause();
      this.$router.push(this.isVoted ? "/score" : router);
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
        this.isVoted = true;
        return;
      }
    },
  },
  mounted() {
    particlesJS("home", particlesSetting);
    document.title = this.sport.name;
    this.getStep();
  },
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
