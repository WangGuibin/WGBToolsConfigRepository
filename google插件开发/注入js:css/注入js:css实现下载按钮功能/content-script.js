(function () {
	var style = document.createElement("style");
	style.innerText = `.btn {
	   position: absolute;
	   bottom: 4%;
	   right: 1%;
	   transform: translate(-50%, -50%);
	   width: 200px;
	   height: 60px;
	   line-height: 60px;
	   text-align: center;
	   color: #fff;
	   font-family: 'mono-font';
	   font-size: 20px;
	   cursor: pointer;
	   background: linear-gradient(90deg, #03a9f4, #f441a5, #ffeb3b, #03a9f4);
	   background-size: 400%;
	   border-radius: 30px;
   }

   .btn:hover {
	   animation: animate 8s linear infinite;
   }

   @keyframes animate {
	   0% {
		   background-position: 0%;
	   }

	   100% {
		   background-position: 400%;
	   }
   }

   .btn::before {
	   content: '';
	   position: absolute;
	   top: -5px;
	   left: -5px;
	   right: -5px;
	   bottom: -5px;
	   z-index: -1;
	   background: linear-gradient(90deg, #03a9f4, #f441a5, #ffeb3b, #03a9f4);
	   background-size: 400%;
	   border-radius: 40px;
	   opacity: 0;
	   transition: 0.5s;
   }

   .btn:hover::before {
	   filter: blur(20px);
	   opacity: 1;
	   animation: animate 8s linear infinite;
   }`;
	document.body.appendChild(style);
	var btn = document.createElement("b");
	btn.innerText = "下载视频";
	btn.className = "btn";
	document.body.appendChild(btn);
	btn.onclick = function () {
		var urlLink = window.location.href;
		urlLink = urlLink.replace('load', 'download/load')
		window.location.href = urlLink
	};

})();