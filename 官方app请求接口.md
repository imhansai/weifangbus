1. 获取 banner 图
   GET /BusService/QueryBannerInfo/?PackageName=com.hisense.wfbus2&Random=168&SignKey=92ab90d043ab250dbfb916aa269a1684b6f50d58c63180693792d8c8953ba77c&UseFor=4&timeStamp=20231012135229 HTTP/1.1
2. 获取线路数据
   GET /BusService/Query_AllSubRouteData/?PackageName=com.hisense.wfbus2&Random=182&SignKey=87f7cd6b811f282606884af4af0ba597e37932dea972551e1ab351b70ad4ebe7&timeStamp=20231012135229 HTTP/1.1
3. 获取咨询消息
   GET /BusService/Query_ByNewInfoSummary/?PackageName=com.hisense.wfbus2&Random=110&SignKey=fda038f153f07cfc1abc642a9ac055d48d5672be496541e0a2334796288da3b7&UseFor=0&timeStamp=20231012135230 HTTP/1.1
4. 获取线路详情
   GET /BusService/Query_RouteStatData/?PackageName=com.hisense.wfbus2&Random=108&RouteID=%40E?%40&SignKey=0eb8ed79d7b1c3aa3b4f009ccca455aa73febd957de667fb5c6052210eb0cf9e&timeStamp=20231012135814 HTTP/1.1
5. 根据站点获取本线路实时信息
   GET /BusService/Query_ByStationIDReturnAll/?IsmainsubCombine=&PackageName=com.hisense.wfbus2&Random=165&RouteID=%40E?%40&SignKey=808993a0c01a58af5af526b3be939c2e326199665839209bd5d76fc3b494a64b&StationID=DD%40F?AA?%40D?FA?H?????&timeStamp=20231012135815 HTTP/1.1
6. 最近发车
   GET /BusService/Query_LinemomentNP/?PackageName=com.hisense.wfbus2&Random=175&RouteID=%40E?%40&SignKey=03f1dbe310ae40d38421f1a7c22da3fe03fa4262e8c35596ac1ff5c806f4232b&timeStamp=20231012140425 HTTP/1.1
7. 计划时刻
   GET /BusService/Query_LinemomentDisplan/?PackageName=com.hisense.wfbus2&Random=186&RouteID=%40E?%40&SignKey=3f45302a0d29a3e022211abba41ec7cc61d30dcaaabc369177e4a650d58fd4ee&timeStamp=20231012140449 HTTP/1.1
8. 