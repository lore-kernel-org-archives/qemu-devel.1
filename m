Received: from eggs.gnu.org ([209.51.188.92]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7DJ-00077a-3k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7DH-0003nF-5X
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:25:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7DH-0003ko-0t
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:24:59 -0400
Received: by mail-oi1-x241.google.com with SMTP id t189so5393423oih.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-27-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:24:42 +0100
Message-ID: <CAFEAcA8AzZCGVyGqUpc1hck4rrBiuUz1atuwLiteyk_ukNhhEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 26/36] target/tricore: Use
 env_cpu
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

On Thu, 28 Mar 2019 at 23:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/tricore/cpu.h       | 5 -----
>  target/tricore/op_helper.c | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
