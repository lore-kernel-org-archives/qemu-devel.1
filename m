Received: from eggs.gnu.org ([2001:4830:134:3::10]:52466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEd6-00029h-JA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEd5-0003Hd-RB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:39:12 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEd5-0003HO-MO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:39:11 -0400
Received: by mail-ot0-x242.google.com with SMTP id t1-v6so14528783oth.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:39:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-24-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:38:50 +0100
Message-ID: <CAFEAcA-vUbNEZZtYQV=72bKX6JsEmLEQHWsH914o=QEWf0vDaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 23/27] fpu/softfloat: Remove
 floatX_maybe_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> These functions are now unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 63 --------------------------------------
>  include/fpu/softfloat.h    |  5 ---
>  2 files changed, 68 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
