Received: from eggs.gnu.org ([209.51.188.92]:40878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSVo-0004Up-Mv
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSVk-00033g-4S
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:40:35 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkSVY-0002bx-TZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:40:22 -0500
Received: by mail-oi1-x243.google.com with SMTP id x23so8744002oix.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-13-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 11:40:01 +0000
Message-ID: <CAFEAcA_mAW1Nrj4O-+QPArGXLMfPaYLeUuP0XxB6w=mtNmiy_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/31] target/arm: Rearrange decode in
 disas_uncond_b_reg
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

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will enable PAuth decode in a subsequent patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 47 +++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 11 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
