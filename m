Received: from eggs.gnu.org ([209.51.188.92]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL72a-00072j-DN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL72Z-0002Ti-K6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL72Z-0002TK-EM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so5361621oig.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-14-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:13:43 +0100
Message-ID: <CAFEAcA9nhXHsWLQPB-fXRXCzweGdQCXsy2q1VJewbK075cWX+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 13/36] target/lm32: Use env_cpu,
 env_archcpu
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

On Thu, 28 Mar 2019 at 23:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/lm32/cpu.h       |  5 -----
>  target/lm32/helper.c    | 19 ++++++-------------
>  target/lm32/op_helper.c |  6 +++---
>  target/lm32/translate.c |  2 +-
>  4 files changed, 10 insertions(+), 22 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
