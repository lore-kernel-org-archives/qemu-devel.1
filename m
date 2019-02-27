Received: from eggs.gnu.org ([209.51.188.92]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Fm-0005pN-22
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Fk-0004Ir-TI
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:04:41 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8Fk-00049f-JY
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:04:40 -0500
Received: by mail-pg1-x542.google.com with SMTP id 196so8672021pgf.13
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:04:27 -0800 (PST)
References: <20190223232954.7185-6-richard.henderson@linaro.org>
	<20190227120217.20794-1-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8a75992-65a2-ed29-2d1b-a0008bfea84c@linaro.org>
Date: Wed, 27 Feb 2019 15:04:19 -0800
MIME-Version: 1.0
In-Reply-To: <20190227120217.20794-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] test/decode: Add tests for PatternGroups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: f4bug@amsat.org, qemu-devel@nongnu.org

On 2/27/19 4:02 AM, Bastian Koppelmann wrote:
> this adds one test that supposed to succeed to test deep nesting
> of pattern groups which is rarely exercised by targets using decode
> tree. The remaining tests exercise various fail conditions.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
> These are the tests that came to my mind. It's not complete,but a
> start.

Thanks for these.  Will queue for v2.


r~
