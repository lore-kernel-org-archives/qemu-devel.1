Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhM4-0007ME-Bf
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhM3-0003AL-Hn
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:39:48 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqhM3-00039o-Cv
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:39:47 -0500
Received: by mail-oi0-x22d.google.com with SMTP id c83so13190607oib.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:39:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-67-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-67-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:39:26 +0000
Message-ID: <CAFEAcA-NLtqSyKLGwyD_JqKGCNz9mZYBbUzxUtHUYsszc+qAfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 66/67] target/arm: Implement
 SVE floating-point round to integral value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 14 ++++++++
>  target/arm/sve_helper.c    |  8 +++++
>  target/arm/translate-sve.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  9 ++++++
>  4 files changed, 111 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
