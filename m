Received: from eggs.gnu.org ([2001:4830:134:3::10]:35999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDPd-0000SF-El
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDPc-0004W1-Ip
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:29:21 -0500
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:43141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDPc-0004UP-Cj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:29:20 -0500
Received: by mail-pf0-x233.google.com with SMTP id z14so3509327pfe.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:29:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-20-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:28:59 +0000
Message-ID: <CAFEAcA-vhL6J2Ug=GBbecK4J2gVB12niZzneswvzzJ1H2j_fLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 19/67] target/arm: Implement
 SVE Bitwise Shift - Unpredicated Group
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
>  target/arm/helper-sve.h    | 12 +++++++
>  target/arm/sve_helper.c    | 30 +++++++++++++++++
>  target/arm/translate-sve.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 26 +++++++++++++++
>  4 files changed, 149 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
