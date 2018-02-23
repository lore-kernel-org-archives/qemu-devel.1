Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGGz-00032q-8r
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGGy-0001ct-Fx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:32:37 -0500
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:44040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGGy-0001bu-9j
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:32:36 -0500
Received: by mail-pl0-x231.google.com with SMTP id w21so5166170plp.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:32:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-38-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 16:32:14 +0000
Message-ID: <CAFEAcA_QLFNN7pRo2ebw0_YOC59wHp59kMdXZ=18OG+kfkic8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 37/67] target/arm: Implement
 SVE Integer Compare - Immediate Group
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
>  target/arm/helper-sve.h    | 44 +++++++++++++++++++++++
>  target/arm/sve_helper.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 63 +++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 23 ++++++++++++
>  4 files changed, 218 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
