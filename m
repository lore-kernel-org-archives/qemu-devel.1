Received: from eggs.gnu.org ([209.51.188.92]:33937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6YB-000728-9y
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6Y9-0002QI-E7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:42:31 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6Y3-0002BA-Q6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:42:25 -0400
Received: by mail-oi1-x241.google.com with SMTP id n187so8289298oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-6-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:42:05 +0100
Message-ID: <CAFEAcA9Vgz4+1GP=k22GeHrcfg243VUgbjcRjzDQtx5iUEcL+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 05/36] cpu: Define ArchCPU
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

On Thu, 28 Mar 2019 at 23:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For all targets, do this just before including exec/cpu-all.h.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
