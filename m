Received: from eggs.gnu.org ([209.51.188.92]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAZY-0001VT-HT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAZX-0006xA-Kl
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:00:12 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAZX-0006wO-FC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:00:11 -0400
Received: by mail-oi1-x244.google.com with SMTP id n187so9046950oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-19-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:59:59 +0100
Message-ID: <CAFEAcA9aOWheZjUCBMh3Bo8zvpeb1e9TvwKroG3Oo6cU1+0NdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 18/26] target/sh4: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, 3 Apr 2019 at 05:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
