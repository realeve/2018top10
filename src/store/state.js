let isMobile = () =>
  navigator.userAgent.match(/Android/i) ||
  navigator.userAgent.match(/webOS/i) ||
  navigator.userAgent.match(/iPhone/i) ||
  navigator.userAgent.match(/iPad/i) ||
  navigator.userAgent.match(/iPod/i) ||
  navigator.userAgent.match(/BlackBerry/i) ||
  navigator.userAgent.match(/Windows Phone/i) ||
  navigator.userAgent.match(/MicroMessenger/i);

const state = {
  isLoading: false,
  userInfo: {},
  cdnUrl: "//api.cbpc.ltd/",
  tips: "",
  isDebug: process.env.NODE_ENV !== "production",
  isPC: !isMobile(),
  sport: {
    id: 1,
    isLogin: true,
    name: '2019年中国印钞造币行业"十件大事"',
    maxTickets: 10,
    allTickets: 15,
    timeRange: "2月17日至28日",
    loadWXInfo: true,
    startDate: "2020-03-25 08:00:00",
    endDate: "2020-05-31 23:59:59",
  },
};

export default state;
