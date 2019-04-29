Received: from eggs.gnu.org ([209.51.188.92]:42010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75a-00015p-3u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75Z-0005es-CI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL75Z-0005U0-7q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:01 -0400
Received: by mail-ot1-x343.google.com with SMTP id u15so8704769otq.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-18-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:16:33 +0100
Message-ID: <CAFEAcA-2n=wjNcLWyNvmewiUryyt+sTXY62jbRyVa3Xmj2ak+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 17/36] target/moxie: Use env_cpu,
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

On Thu, 28 Mar 2019 at 23:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/moxie/cpu.h       | 5 -----
>  target/moxie/helper.c    | 6 +++---
>  target/moxie/translate.c | 2 +-
>  3 files changed, 4 insertions(+), 9 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
