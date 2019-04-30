Received: from eggs.gnu.org ([209.51.188.92]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROQ-0002EI-HB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRIK-0008Mt-8x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:51:32 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRIJ-0008M6-Tn
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:51:32 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so7942482oig.9
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-7-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:51:20 +0100
Message-ID: <CAFEAcA-Qq=mif4eOyH7V-fy4KNYxiuKpyK95mDnmzvHPfv5P1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/26] target/hppa: Convert to
 CPUClass::tlb_fill
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

On Wed, 3 Apr 2019 at 04:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/cpu.h        |  8 ++++----
>  target/hppa/cpu.c        |  5 ++---
>  target/hppa/mem_helper.c | 22 +++++++++++++++++-----
>  3 files changed, 23 insertions(+), 12 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
