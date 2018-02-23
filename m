Received: from eggs.gnu.org ([2001:4830:134:3::10]:45001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDo9-0003O9-M6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDo9-0002ut-11
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:54:41 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:37973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDo8-0002tS-Pk
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:54:40 -0500
Received: by mail-pl0-x22e.google.com with SMTP id d4so4934696pll.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:54:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-23-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:54:19 +0000
Message-ID: <CAFEAcA8OGxchC78-dS6XmLBb64n=+V06xUKfcq8D+dNd9Z=1uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 22/67] target/arm: Implement
 SVE floating-point trig select coefficient
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  4 ++++
>  target/arm/sve_helper.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 19 +++++++++++++++++++
>  target/arm/sve.decode      |  4 ++++
>  4 files changed, 70 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
