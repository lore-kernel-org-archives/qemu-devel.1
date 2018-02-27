Received: from eggs.gnu.org ([2001:4830:134:3::10]:44251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhJM-0005TW-74
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhJL-0000xo-FA
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:37:00 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqhJL-0000xM-A8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:36:59 -0500
Received: by mail-ot0-x244.google.com with SMTP id w38so4136673ota.8
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:36:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-66-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-66-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:36:38 +0000
Message-ID: <CAFEAcA_1hmX9Rr7hLwCXAwrFg_CUSsNPsrAaESKF7JXNo2OqFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 65/67] target/arm: Implement
 SVE floating-point convert to integer
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
>  target/arm/helper-sve.h    | 30 ++++++++++++++++++++
>  target/arm/sve_helper.c    | 16 +++++++++++
>  target/arm/translate-sve.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 16 +++++++++++
>  4 files changed, 132 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
