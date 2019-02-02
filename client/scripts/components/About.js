import React, { Component } from 'react';
import { Link } from 'react-router';

class About extends Component {
  render() {
    return (
      <div className="about">
        
        <div className="title">
            feed<span className="me">me</span>music        
        </div>
        <p>
          The latest music album reviews for Spotify listeners, gathered together from the best review sites on the web.
        </p>
        <p>
          This website is a non-commercial hobby project born out of a passion for discovering new music online.
        </p>
        
        <p>
          <a href="https://github.com/nicklangridge/feedme/" target="_blank">
            <span className="icon ion-social-github"></span>get the code on github
          </a> 
        </p>
        
        <div className="credits">
          <p className="spotify">
            <svg xmlns="http://www.w3.org/2000/svg" height="25px" width="85px" version="1.1" viewBox="0 0 559 168">
              <path fill="#1ED760" d="m83.996 0.277c-46.249 0-83.743 37.493-83.743 83.742 0 46.251 37.494 83.741 83.743 83.741 46.254 0 83.744-37.49 83.744-83.741 0-46.246-37.49-83.738-83.745-83.738l0.001-0.004zm38.404 120.78c-1.5 2.46-4.72 3.24-7.18 1.73-19.662-12.01-44.414-14.73-73.564-8.07-2.809 0.64-5.609-1.12-6.249-3.93-0.643-2.81 1.11-5.61 3.926-6.25 31.9-7.288 59.263-4.15 81.337 9.34 2.46 1.51 3.24 4.72 1.73 7.18zm10.25-22.802c-1.89 3.072-5.91 4.042-8.98 2.152-22.51-13.836-56.823-17.843-83.448-9.761-3.453 1.043-7.1-0.903-8.148-4.35-1.04-3.453 0.907-7.093 4.354-8.143 30.413-9.228 68.222-4.758 94.072 11.127 3.07 1.89 4.04 5.91 2.15 8.976v-0.001zm0.88-23.744c-26.99-16.031-71.52-17.505-97.289-9.684-4.138 1.255-8.514-1.081-9.768-5.219-1.254-4.14 1.08-8.513 5.221-9.771 29.581-8.98 78.756-7.245 109.83 11.202 3.73 2.209 4.95 7.016 2.74 10.733-2.2 3.722-7.02 4.949-10.73 2.739zm94.56 3.072c-14.46-3.448-17.03-5.868-17.03-10.953 0-4.804 4.52-8.037 11.25-8.037 6.52 0 12.98 2.455 19.76 7.509 0.2 0.153 0.46 0.214 0.71 0.174 0.26-0.038 0.48-0.177 0.63-0.386l7.06-9.952c0.29-0.41 0.21-0.975-0.18-1.288-8.07-6.473-17.15-9.62-27.77-9.62-15.61 0-26.52 9.369-26.52 22.774 0 14.375 9.41 19.465 25.67 23.394 13.83 3.187 16.17 5.857 16.17 10.629 0 5.29-4.72 8.58-12.32 8.58-8.44 0-15.33-2.85-23.03-9.51-0.19-0.17-0.45-0.24-0.69-0.23-0.26 0.02-0.49 0.14-0.65 0.33l-7.92 9.42c-0.33 0.4-0.29 0.98 0.09 1.32 8.96 8 19.98 12.22 31.88 12.22 16.82 0 27.69-9.19 27.69-23.42 0.03-12.007-7.16-18.657-24.77-22.941l-0.03-0.013zm62.86-14.26c-7.29 0-13.27 2.872-18.21 8.757v-6.624c0-0.523-0.42-0.949-0.94-0.949h-12.95c-0.52 0-0.94 0.426-0.94 0.949v73.601c0 0.52 0.42 0.95 0.94 0.95h12.95c0.52 0 0.94-0.43 0.94-0.95v-23.23c4.94 5.53 10.92 8.24 18.21 8.24 13.55 0 27.27-10.43 27.27-30.369 0.02-19.943-13.7-30.376-27.26-30.376l-0.01 0.001zm12.21 30.375c0 10.149-6.25 17.239-15.21 17.239-8.85 0-15.53-7.41-15.53-17.239 0-9.83 6.68-17.238 15.53-17.238 8.81-0.001 15.21 7.247 15.21 17.237v0.001zm50.21-30.375c-17.45 0-31.12 13.436-31.12 30.592 0 16.972 13.58 30.262 30.91 30.262 17.51 0 31.22-13.39 31.22-30.479 0-17.031-13.62-30.373-31.01-30.373v-0.002zm0 47.714c-9.28 0-16.28-7.46-16.28-17.344 0-9.929 6.76-17.134 16.07-17.134 9.34 0 16.38 7.457 16.38 17.351 0 9.927-6.8 17.127-16.17 17.127zm68.27-46.53h-14.25v-14.566c0-0.522-0.42-0.948-0.94-0.948h-12.95c-0.52 0-0.95 0.426-0.95 0.948v14.566h-6.22c-0.52 0-0.94 0.426-0.94 0.949v11.127c0 0.522 0.42 0.949 0.94 0.949h6.22v28.795c0 11.63 5.79 17.53 17.22 17.53 4.64 0 8.49-0.96 12.12-3.02 0.3-0.16 0.48-0.48 0.48-0.82v-10.6c0-0.32-0.17-0.63-0.45-0.8-0.28-0.18-0.63-0.19-0.92-0.04-2.49 1.25-4.9 1.83-7.6 1.83-4.15 0-6.01-1.89-6.01-6.11v-26.76h14.25c0.52 0 0.94-0.426 0.94-0.949v-11.126c0.02-0.523-0.4-0.949-0.93-0.949l-0.01-0.006zm49.64 0.057v-1.789c0-5.263 2.02-7.61 6.54-7.61 2.7 0 4.87 0.536 7.3 1.346 0.3 0.094 0.61 0.047 0.85-0.132 0.25-0.179 0.39-0.466 0.39-0.77v-10.91c0-0.417-0.26-0.786-0.67-0.909-2.56-0.763-5.84-1.546-10.76-1.546-11.95 0-18.28 6.734-18.28 19.467v2.74h-6.22c-0.52 0-0.95 0.426-0.95 0.948v11.184c0 0.522 0.43 0.949 0.95 0.949h6.22v44.405c0 0.53 0.43 0.95 0.95 0.95h12.94c0.53 0 0.95-0.42 0.95-0.95v-44.402h12.09l18.52 44.402c-2.1 4.66-4.17 5.59-6.99 5.59-2.28 0-4.69-0.68-7.14-2.03-0.23-0.12-0.51-0.14-0.75-0.07-0.25 0.09-0.46 0.27-0.56 0.51l-4.39 9.63c-0.21 0.46-0.03 0.99 0.41 1.23 4.58 2.48 8.71 3.54 13.82 3.54 9.56 0 14.85-4.46 19.5-16.44l22.46-58.037c0.12-0.292 0.08-0.622-0.1-0.881-0.17-0.257-0.46-0.412-0.77-0.412h-13.48c-0.41 0-0.77 0.257-0.9 0.636l-13.81 39.434-15.12-39.46c-0.14-0.367-0.49-0.61-0.88-0.61h-22.12v-0.003zm-28.78-0.057h-12.95c-0.52 0-0.95 0.426-0.95 0.949v56.481c0 0.53 0.43 0.95 0.95 0.95h12.95c0.52 0 0.95-0.42 0.95-0.95v-56.477c0-0.523-0.42-0.949-0.95-0.949v-0.004zm-6.4-25.719c-5.13 0-9.29 4.152-9.29 9.281 0 5.132 4.16 9.289 9.29 9.289s9.28-4.157 9.28-9.289c0-5.128-4.16-9.281-9.28-9.281zm113.42 43.88c-5.12 0-9.11-4.115-9.11-9.112s4.04-9.159 9.16-9.159 9.11 4.114 9.11 9.107c0 4.997-4.04 9.164-9.16 9.164zm0.05-17.365c-4.67 0-8.2 3.71-8.2 8.253 0 4.541 3.51 8.201 8.15 8.201 4.67 0 8.2-3.707 8.2-8.253 0-4.541-3.51-8.201-8.15-8.201zm2.02 9.138l2.58 3.608h-2.18l-2.32-3.31h-1.99v3.31h-1.82v-9.564h4.26c2.23 0 3.69 1.137 3.69 3.051 0.01 1.568-0.9 2.526-2.21 2.905h-0.01zm-1.54-4.315h-2.37v3.025h2.37c1.18 0 1.89-0.579 1.89-1.514 0-0.984-0.71-1.511-1.89-1.511z"/>
            </svg>
            This product uses a SPOTIFY API but is not endorsed,certified or 
            otherwise approved in any way by Spotify. Spotify is the registered 
            trade mark of the Spotify Group.
          </p>
          
          <p>
            <svg class="SVGInline-svg" width="80px" height="14px" viewBox="0 0 181 32" version="1.1">
              <g id="Website" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <g id="Amp" transform="translate(-100.000000, -24.000000)" fill="#555">
                  <path d="M218.298962,56 C216.385913,56 214.65506,55.7555517 213.106402,55.2691947 C211.557743,54.781568 210.236829,54.0501278 209.143658,53.0748742 C208.050488,52.0989857 207.207835,50.8653153 206.615701,49.3719583 C206.023567,47.8786012 205.7275,46.1255575 205.7275,44.114097 L205.7275,24.7309322 L215.429389,24.7309322 L215.429389,43.7032969 C215.429389,44.7699805 215.649542,45.5852315 216.089846,46.1484151 C216.530151,46.7128685 217.266523,46.9941428 218.298962,46.9941428 C219.330768,46.9941428 220.067773,46.7128685 220.508078,46.1484151 C220.94775,45.5852315 221.168535,44.7699805 221.168535,43.7032969 L221.168535,24.7309322 L230.915973,24.7309322 L230.915973,44.114097 C230.915973,46.1255575 230.619906,47.8786012 230.027772,49.3719583 C229.435637,50.8653153 228.585394,52.0989857 227.47704,53.0748742 C226.368054,54.0501278 225.040181,54.781568 223.491522,55.2691947 C221.942864,55.7555517 220.212011,56 218.298962,56 Z M232.069559,24.7310592 L242.545777,24.7310592 C244.488559,24.7310592 246.287735,24.9907459 247.943307,25.5082144 C249.598246,26.0269528 251.033032,26.7882347 252.247666,27.793965 C253.461667,28.7996952 254.411233,30.0422546 255.094464,31.5197384 C255.777696,32.998492 256.119312,34.6969317 256.119312,36.6169622 C256.119312,38.1414308 255.906751,39.4366895 255.481629,40.5033731 C255.056507,41.5700567 254.585836,42.4538802 254.069617,43.1542088 C253.461667,43.9472373 252.778436,44.6170892 252.019922,45.1656693 L257.713519,55.2229718 L246.326325,55.2229718 L241.771448,47.4971349 L241.771448,55.2229718 L232.069559,55.2229718 L232.069559,24.7310592 Z M241.771448,39.7255829 L242.272484,39.7255829 C243.426387,39.7255829 244.405685,39.4671661 245.21038,38.9484278 C246.015075,38.4309592 246.417423,37.562374 246.417423,36.3426721 C246.417423,35.1242401 246.015075,34.2556549 245.21038,33.7369165 C244.405685,33.2194479 243.426387,32.9597613 242.272484,32.9597613 L241.771448,32.9597613 L241.771448,39.7255829 Z M261.599842,40.6742329 L252.171245,24.57239 L261.701061,24.57239 L266.473561,32.9229988 L271.200511,24.57239 L280.730327,24.57239 L271.301731,40.6742329 L271.301731,55.0643026 L261.599842,55.0643026 L261.599842,40.6742329 Z M177.082951,43.1542723 C177.139254,43.0787155 177.192395,42.99173 177.2468,42.9117288 C177.108888,41.9713964 177.03677,40.9999524 177.03677,39.9999365 C177.03677,37.3979904 177.501114,35.0049366 178.417151,32.8880776 C178.455108,32.8004572 178.502554,32.7198209 178.541777,32.6328354 C178.416518,32.2493373 178.272913,31.8772679 178.107798,31.5198019 C177.424567,30.0423181 176.475001,28.7997587 175.261,27.7940285 C174.046366,26.7882982 172.61158,25.9895554 170.956641,25.470817 C169.301069,24.9533485 167.501893,24.655566 165.559111,24.655566 L155.161338,24.655566 L155.161338,55.1322402 L164.650666,55.1322402 L164.650666,47.4971984 L169.339659,55.1322402 L180.726853,55.1322402 L175.033256,45.1206527 C175.79177,44.5720726 176.475001,43.9473008 177.082951,43.1542723 Z M168.223714,39.032937 C167.419019,39.5510405 166.439721,39.8939031 165.285818,39.8939031 L164.650666,39.8939031 L164.650666,32.9096652 L165.285818,32.9096652 C166.439721,32.9096652 167.419019,33.1947491 168.223714,33.7122177 C169.027777,34.230956 169.430757,35.1541453 169.430757,36.3725773 C169.430757,37.5916443 169.027777,38.5154685 168.223714,39.032937 Z M123.846682,24.7309322 L116.574693,35.1641137 L109.454534,24.7309322 L100,24.7309322 L100,55.2228448 L109.701889,55.2228448 L109.701889,42.3464499 L116.574693,50.8545215 L123.401948,42.3464499 L123.401948,55.2228448 L133.103837,55.2228448 L133.103837,24.7309322 L123.846682,24.7309322 Z M134.394386,24.7309322 L153.560298,24.7309322 L153.560298,32.7316942 L144.096275,32.7316942 L144.096275,36.114605 L152.158408,36.114605 L152.158408,43.7032969 L144.096275,43.7032969 L144.096275,47.2233528 L153.87914,47.2233528 L153.87914,55.2228448 L134.394386,55.2228448 L134.394386,24.7309322 Z M178.30195,40.000254 C178.30195,37.56212 178.727072,35.3595454 179.577316,33.3944348 C180.426927,31.4286893 181.581462,29.7448531 183.039023,28.3429261 C184.496583,26.941634 186.196438,25.8666963 188.140485,25.1193828 C190.0839,24.3733393 192.148778,24 194.335119,24 C196.065972,24 197.607039,24.1669868 198.95832,24.5028651 C200.308967,24.8381085 201.471094,25.219067 202.442801,25.6457404 C203.566337,26.1333672 204.538044,26.666709 205.357922,27.2451309 L200.575301,35.702408 C200.088815,35.3366879 199.557412,34.9868411 198.981094,34.6509627 C198.464242,34.4077843 197.849333,34.1709551 197.136369,33.943015 C196.422771,33.7144399 195.610485,33.6001524 194.699509,33.6001524 C193.758168,33.6001524 192.892108,33.7677741 192.103229,34.1030175 C191.313084,34.4382609 190.622894,34.895411 190.03076,35.4744678 C189.438626,36.0535247 188.975546,36.7316307 188.641522,37.5081509 C188.306865,38.285941 188.140485,39.1164304 188.140485,40.000254 C188.140485,40.8847125 188.315089,41.713932 188.664296,42.4917221 C189.012871,43.2682424 189.491133,43.9476182 190.099083,44.5260401 C190.7064,45.1050969 191.419997,45.562247 192.239875,45.8968555 C193.059753,46.2327339 193.954913,46.3997206 194.927253,46.3997206 C195.89896,46.3997206 196.764387,46.2790838 197.523533,46.0346355 C198.282047,45.7908221 198.91973,45.516532 199.436582,45.2117653 C200.043899,44.8765218 200.575301,44.4803251 201.030789,44.023175 L205.81341,52.4798171 C204.993532,53.1509389 204.021192,53.7452341 202.898289,54.2633375 C201.925949,54.6906459 200.757496,55.0862077 199.391033,55.4519278 C198.02457,55.817013 196.460096,55.999873 194.699509,55.999873 C192.330973,55.999873 190.144632,55.6119303 188.140485,54.8341402 C186.136339,54.05762 184.405486,52.9680789 182.947925,51.5661518 C181.490364,50.1648598 180.351645,48.4797536 179.531767,46.5146431 C178.711889,44.5488976 178.30195,42.3767996 178.30195,40.000254 Z" id="merc-logo"></path>
                </g>
              </g>
            </svg>
            Many of the content excerpts that appear on this website were generated by the Mercury web API.
          </p>
        </div>
      </div>
    );
  }
}

export default About;
