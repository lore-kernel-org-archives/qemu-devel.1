Received: from eggs.gnu.org ([208.118.235.92]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSI4-0005K3-JP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSI4-0002Kh-0X
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:25:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfSI3-0002KO-SQ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:25:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id y23so30763391oia.4
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 08:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-2-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 16:25:32 +0000
Message-ID: <CAFEAcA-EO-vB5mFO+G2hqLcyRQ4-cMPHL-1qkLa-xPpmFa8zsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 01/27] target/arm: Add state for the
 ARMv8.3-PAuth extension
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add storage space for the 5 encryption keys.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
> v2: Remove pointless double migration.
>     Use a struct to make it clear which half is which.
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
