Received: from eggs.gnu.org ([208.118.235.92]:41394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbxfg-0004A4-NK
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 20:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbxfc-0007LJ-GO
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 20:07:40 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:44394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbxfc-0007KA-AA
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 20:07:36 -0500
Received: by mail-pg1-x52c.google.com with SMTP id t13so6940413pgr.11
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 17:07:36 -0800 (PST)
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
Date: Wed, 26 Dec 2018 12:07:27 +1100
MIME-Version: 1.0
In-Reply-To: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>, qemu-devel@nongnu.org

On 12/26/18 10:43 AM, Nick Renieris wrote:
> Hello,
> 
> What's the current status on AVX support for TCG? Is there anyone working on it?
> Is there interest for it?

A couple of people, including myself, have started on it, but no results posted
so far.  It's a large amount of work to clean up the exiting sse support before
avx could be added.


r~
