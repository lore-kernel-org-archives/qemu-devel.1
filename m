Received: from eggs.gnu.org ([2001:4830:134:3::10]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhDy-0001FP-TL
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhDx-0006DO-TC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:31:26 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqhDx-0006Cx-OG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:31:25 -0500
Received: by mail-ot0-x22c.google.com with SMTP id h8so4121859oti.6
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:31:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-63-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:31:04 +0000
Message-ID: <CAFEAcA-KWSNgAtZvxrfdJ5YMv4og2bmj2p3sFKAaHhdmFD66tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 62/67] target/arm: Implement SVE FP
 Compare with Zero Group
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
>  target/arm/helper-sve.h    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 10 ++++++++++
>  4 files changed, 138 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
