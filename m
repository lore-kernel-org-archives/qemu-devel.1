Received: from eggs.gnu.org ([2001:4830:134:3::10]:38733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDVE-0004wt-BA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDVA-0007Aw-KR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:35:08 -0500
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:46379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDVA-00079V-D7
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:35:04 -0500
Received: by mail-pl0-x232.google.com with SMTP id x19so4902252plr.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:35:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-21-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:34:42 +0000
Message-ID: <CAFEAcA9nmk2Ca4nVeK+N2hy6ke6_E8LieAdJFrd-ZvwZsiNphA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 20/67] target/arm: Implement SVE Compute
 Vector Address Group
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
>  target/arm/helper-sve.h    |  5 +++++
>  target/arm/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 12 ++++++++++++
>  4 files changed, 90 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
