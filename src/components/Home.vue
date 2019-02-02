<template>
  <div style="background:#f2f3f8">
    <x-header></x-header>
    <toast
      v-model="toast.show"
      :type="toast.type"
    >{{ toast.text }}</toast>
    <div class="company_name">
      <p>
        请先选择您所属单位
      </p>
      <group style="margin-top:-10px;">
        <selector
          title="下属企业"
          :options="companyList"
          v-model="company_name"
        ></selector>

      </group>
    </div>
    <div v-show="company_name.length">
      <div
        class="vote"
        v-for="(item,i) in checkList"
        :key="item.id"
      >
        <div class="header">
          <img
            v-if="item.img.length==1"
            :src="item.img[0].img"
          >
          <swiper
            v-else
            loop
            auto
            inter
            :show-desc-mask="false"
            :interval="1300+Math.random()*2000"
            :list="item.img"
          />
          <p
            class="main-title"
            :style="{
          bottom:item.img.length===1?'5px':'0px'
        }"
          >{{i | chinese}}、{{item.title}}</p>
        </div>
        <p class="desc">{{item.content}}</p>

        <div class="weui-cell switch">
          <span>投它一票</span>
          <span>{{progress}}</span>
          <input
            type="checkbox"
            class="weui-switch"
            v-model="valueList[i]"
            @on-change="checkMaxVotes(i)"
          >
        </div>
        <div class="split">
          <div class="shadow"></div>
        </div>
      </div>

      <p
        style="margin-top:20px;"
        v-show="myChecked.length"
      >我的选择</p>
      <div class="weui-cells weui-cells_checkbox">
        <label
          class="weui-cell weui-check_label"
          v-for="(item,i) in myChecked"
          :key="item.id"
        >
          <div class="weui-cell__bd">
            <p>{{i+1}}.{{item.title}}</p>
          </div>
        </label>
      </div>

      <div class="submit">
        <x-button
          :disabled="maxnum!=sport.maxTickets"
          @click.native="submit"
          type="primary"
        >提交数据</x-button>
        <x-button
          @click.native="addInfo"
          type="default"
        >填写个人信息</x-button>
      </div>
    </div>

    <x-footer />
  </div>

</template>

<script>
import {
  Sticky,
  Group,
  Cell,
  Card,
  Divider,
  Toast,
  XButton,
  Swiper,
  Selector
  // XAddress,
} from "vux";
import XFooter from "./Footer";
import XHeader from "./Header";
import _checkList from "../js/checkList";
import util from "../js/common";
import { mapState } from "vuex";
import * as db from "../js/db";

import moment from "moment";
import companyList from "../js/companyList";

export default {
  components: {
    Sticky,
    Group,
    Cell,
    Divider,
    Card,
    Toast,
    XButton,
    XHeader,
    XFooter,
    Swiper,
    Selector
    // XAddress,
  },
  data() {
    return {
      valueList: [],
      toast: {
        show: false,
        text: "",
        type: ""
      },
      voteNum: [],
      checkList: _checkList, //util.randomArr(_checkList),
      time: new Date().getTime(),
      ip: "",
      companyList,
      company_name: ""
    };
  },
  computed: {
    ...mapState(["cdnUrl", "sport", "userInfo"]),
    maxnum() {
      let count = this.valueList.filter(item => item);
      return count.length;
    },
    openid() {
      return this.userInfo.openid;
    },
    curTimeStamp() {
      return (new Date().getTime() / 1000).toFixed(0);
    },
    progress() {
      return this.maxnum + "/" + this.sport.maxTickets;
    },
    myChecked() {
      let arr = [];
      this.checkList.forEach((item, i) => {
        if (this.valueList[i]) {
          arr.push(item);
        }
      });
      return arr;
    },
    isSportEnd() {
      return moment().format("YYYY-MM-DD HH:mm:ss") > this.sport.endDate;
    },
    company_id() {
      if (this.company_name == "") {
        return -1;
      }
      let idx = companyList.findIndex(item => item == this.company_name);
      return idx + 1;
    }
  },
  filters: {
    chinese(i) {
      return [
        "一",
        "二",
        "三",
        "四",
        "五",
        "六",
        "七",
        "八",
        "九",
        "十",
        "十一",
        "十二",
        "十三",
        "十四",
        "十五"
      ][i];
    }
  },
  methods: {
    showToast(settings) {
      this.toast.text = settings.text;
      this.toast.type = settings.type;
      this.toast.show = true;
      setTimeout(() => {
        this.toast.show = false;
      }, 1500);
    },
    checkMaxVotes(i) {
      if (this.maxnum > this.sport.maxTickets) {
        this.showToast({
          text: "请勿超过" + this.sport.maxTickets + "票",
          type: "warn"
        });
      }
    },
    getOriginIdx(newIdx) {
      return this.checkList[newIdx].id;
    },
    async submit() {
      let arr = [];
      this.valueList.forEach((item, i) => {
        if (item) {
          arr.push(i);
        }
      });
      let addStr = arr
        .map(item => this.getOriginIdx(item))
        .sort((a, b) => a - b);
      let params = {
        nickname: this.userInfo.nickname,
        openid: this.userInfo.openid,
        sex: this.userInfo.sex,
        headimgurl: this.userInfo.headimgurl,
        country: this.userInfo.country,
        province: this.userInfo.province,
        city: this.userInfo.city,
        ip: this.ip,
        vote_detail: addStr.join(","),
        company_id: this.company_id
      };

      let res = await db
        .addCbpmVoteMain(params)
        .catch(e => ({ data: [{ affected_rows: -1 }] }));

      let { affected_rows } = res.data[0];

      if (affected_rows == 0) {
        this.showToast({
          text: "数据提交失败",
          type: "warn"
        });
        return;
      } else if (affected_rows == 1) {
        await db.setCbpmVoteList(addStr);
      }
      this.showToast({
        text: "提交成功",
        type: "success"
      });

      setTimeout(() => {
        this.$router.push("/info");
      }, 500);
    },
    async getStep() {
      if (this.isSportEnd) {
        this.$router.push("message");
        return;
      }

      let { rows, ip } = await db.getCbpmVoteMain(this.openid);
      if (rows > 0) {
        this.$router.push("/info");
        return;
      }
      this.ip = ip;
    },
    addInfo() {
      this.$router.push("/info");
    }
  },
  created() {
    this.getStep();

    this.valueList = new Array(_checkList.length).fill(false);
  }
};
</script>

<style scoped lang="less">
@import "../assets/css/switch.css";
.switch {
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  &::before {
    left: 0;
  }
}

.desc {
  padding: 0 10px;
  font-size: 16px;
  line-height: 1.6em;
  text-indent: 2.3em;
  letter-spacing: 0.15em;
  text-align: justify;
}
.split {
  position: relative;
  background: #fff;
  height: 24px;
  .shadow {
    height: 12px;
    background: #f2f3f8;
    position: absolute;
    bottom: 0;
    width: 100%;
  }
  &::before {
    content: "";
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 12'%3E%3Cpath d='m12 0l12 12h-24z' fill='%23f2f3f8'/%3E%3C/svg%3E");
    position: absolute;
    width: 100%;
    height: 12px;
    top: 0;
    left: 0;
  }
}
.company_name {
  margin: 0 0 20px 0;
}
.vote {
  background: #fff;
  .header {
    position: relative;
    img {
      width: 100%;
    }
    .main-title {
      position: absolute;
      bottom: 5px;
      background-image: linear-gradient(
        to bottom,
        rgba(0, 0, 0, 0) 0,
        rgba(0, 0, 0, 0.1) 15%,
        rgba(0, 0, 0, 0.8) 100%
      );
      color: #fff;
      text-align: justify;
      padding: 5px;
      width: 100%;
      line-height: 1.3em;
    }
  }
}

.submit {
  margin: 10px 15px 25px 15px;
}
.weui-cell__bd p {
  text-align: left;
}
</style>
