Received: from eggs.gnu.org ([209.51.188.92]:56408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6E-0007Np-6T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y3V-0006mL-Q7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:26:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y3V-0006lx-Dv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:26:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id 125so691508pgc.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:26:17 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84b54deb-2d27-7114-a315-0e8f12b6e6a2@linaro.org>
Date: Mon, 11 Mar 2019 20:26:13 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-4-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/11] target/hppa: report ITLB_EXCP_MISS
 for ITLB misses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:15 PM, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/mem_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

At one point this didn't boot linux, but perhaps there was a second bug.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
