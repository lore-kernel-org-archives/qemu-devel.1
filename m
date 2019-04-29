Received: from eggs.gnu.org ([209.51.188.92]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6XK-0006NN-Nu
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6XJ-0001qg-UY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:41:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6XJ-0001q0-NN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:41:37 -0400
Received: by mail-ot1-x341.google.com with SMTP id 77so2450718otu.13
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-5-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:41:25 +0100
Message-ID: <CAFEAcA8CVzBvy6KR38_k42YVX+G57MVSfrRU8wcFXkf7ZuxXDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 04/36] cpu: Define CPUArchState
 with typedef
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

On Thu, 28 Mar 2019 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For all targets, do this just before including exec/cpu-all.h.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
