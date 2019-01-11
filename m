Received: from eggs.gnu.org ([209.51.188.92]:43976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi5Xo-0008WU-WF
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi5Xo-0006hL-Af
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:44:52 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gi5Xn-0006gj-WB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:44:52 -0500
Received: by mail-pg1-x542.google.com with SMTP id v28so6885931pgk.10
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:44:51 -0800 (PST)
References: <20190111220131.27153-1-jcmvbkbc@gmail.com>
	<2064503c-ed12-de29-59a9-46fa24d22f60@linaro.org>
	<CAMo8BfJaTbO0LSBWk7+WeFw7Oc6Sy2ykxaQcWTBeVGCdN9+aOg@mail.gmail.com>
	<cdaaa0bc-8282-6a92-886a-7dd5f2adfa46@linaro.org>
	<CAMo8Bf+FJUO46mv8bg7Rd2vH+noTsDHBrcfY=mbchaJoDd5eng@mail.gmail.com>
	<CAMo8Bf+oiqDn9+RSiUXKwXfzWemJNrc6AQMRLMEbNSA3tfMavw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd7d28cc-ef48-bc63-6e6f-248f3ec56e35@linaro.org>
Date: Sat, 12 Jan 2019 09:44:45 +1100
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+oiqDn9+RSiUXKwXfzWemJNrc6AQMRLMEbNSA3tfMavw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: rework zero overhead
 loops implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 1/12/19 9:27 AM, Max Filippov wrote:
> Maybe "Any other value means that an instruction that ends at this offset
> from the page start may loop back and will need loopback code to be generated"?

Much better, thanks.


r~
