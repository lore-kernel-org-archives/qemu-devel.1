Received: from eggs.gnu.org ([209.51.188.92]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75n-0001Dy-1v
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75m-0005ph-6M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL75m-0005p9-1S
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id t81so8381899oig.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-19-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:17:02 +0100
Message-ID: <CAFEAcA9owxsLXDf4KcZjCCKM12Ju0h1kHQvi5Whw3Qx1XBeQDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 18/36] target/nios2: Use env_cpu,
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
>  target/nios2/cpu.h |  5 -----
>  hw/nios2/cpu_pic.c |  5 +----
>  target/nios2/mmu.c | 10 +++++-----
>  3 files changed, 6 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
