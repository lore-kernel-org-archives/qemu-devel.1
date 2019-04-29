Received: from eggs.gnu.org ([209.51.188.92]:41774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL74M-0000E1-HL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL74L-0004Nw-DQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:15:46 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL74L-0004Ng-8d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:15:45 -0400
Received: by mail-oi1-x242.google.com with SMTP id t184so5880385oie.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-16-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:15:33 +0100
Message-ID: <CAFEAcA-4gucDfR3tCtd3wXhEOsFQo9URpMfaCEg98brjeWV_uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 15/36] target/microblaze: Use
 env_cpu, env_archcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Mention in the commit message why we needed to move the
definition of cpu_mmu_index() ?

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
