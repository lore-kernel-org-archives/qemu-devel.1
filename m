Received: from eggs.gnu.org ([209.51.188.92]:56195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcjZ-00077C-F4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcfP-00024c-DI
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:44:00 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqcfP-00024O-7W
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:43:59 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so12373788otr.10
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20190128223118.5255-1-richard.henderson@linaro.org>
	<20190128223118.5255-8-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 11:43:47 +0000
Message-ID: <CAFEAcA_-Gn8JaHD7aub0+ZhnhV2Yyx4wTSViHFiDr7p+Ef_CPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/12] target/arm: Reset btype for
 direct branches
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

On Mon, 28 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is all of the non-exception cases of DISAS_NORETURN.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Do not reset byte for syscalls
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
