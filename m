Received: from eggs.gnu.org ([209.51.188.92]:33789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRe4-0003Rq-HS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRe3-0006E3-PC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:14:00 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRe3-0006Dj-Hl
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:13:59 -0400
Received: by mail-ot1-x341.google.com with SMTP id t20so11671751otl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-2-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:13:47 +0100
Message-ID: <CAFEAcA_Uco_Uczy1Ut5RCETtXVxrRpEE35MKHv0mDPYZeFE-mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/6] target/arm: Implement ID_PFR2
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

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This was defined at some point before ARMv8.4, and will
> shortly be used by new processor descriptions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 1 +
>  target/arm/helper.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
