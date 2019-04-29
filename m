Received: from eggs.gnu.org ([209.51.188.92]:34872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6be-0001IM-Vs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6be-0004DS-5u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6be-0004D1-1b
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id k6so8316457oic.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-7-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:45:53 +0100
Message-ID: <CAFEAcA8Hou2fB6VsP9fOe0EE9b6-R6_8AZWtLWFTKADQtKDJVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 06/36] cpu: Replace ENV_GET_CPU
 with env_cpu
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
> Now that we have both ArchCPU and CPUArchState, we can define
> this generically instead of via macro in each target's cpu.h.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
