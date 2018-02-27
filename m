Received: from eggs.gnu.org ([2001:4830:134:3::10]:45420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhNW-0008Ut-LL
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhNV-0004YC-R3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:41:18 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqhNV-0004Wy-Ln
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:41:17 -0500
Received: by mail-oi0-x241.google.com with SMTP id j79so13162382oib.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:41:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-68-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:40:56 +0000
Message-ID: <CAFEAcA812FD=kx3FjFxcF-bM_QEdM0bgo_xmjA8qitgm59aYwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 67/67] target/arm: Implement SVE
 floating-point unary operations
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
>  target/arm/helper-sve.h    | 14 ++++++++++++++
>  target/arm/sve_helper.c    |  8 ++++++++
>  target/arm/translate-sve.c | 28 ++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  4 ++++
>  4 files changed, 54 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
