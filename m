Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfc2-0002CF-K8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfc1-0003bo-VR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:48:10 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfc1-0003bQ-QK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:48:09 -0500
Received: by mail-oi0-x243.google.com with SMTP id a207so12870263oii.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:48:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-48-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-48-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:47:48 +0000
Message-ID: <CAFEAcA9rJ8arjd_TxAp+dJBZPzDS0ajJtG1QapsbP+YNmibL8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 47/67] target/arm: Implement SVE integer
 convert to floating-point
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
>  target/arm/helper-sve.h    | 30 +++++++++++++++
>  target/arm/sve_helper.c    | 52 ++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 22 +++++++++++
>  4 files changed, 196 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
