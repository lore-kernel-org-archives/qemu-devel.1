Received: from eggs.gnu.org ([2001:4830:134:3::10]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDJC-0003Ze-Ci
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDJB-0006Tm-Mb
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:22:42 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:44622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDJB-0006St-HC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:22:41 -0500
Received: by mail-pl0-x234.google.com with SMTP id w21so4881356plp.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:22:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-18-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:22:20 +0000
Message-ID: <CAFEAcA_qhnWLwkL3dht5QVa2mvW-e9+gb6g2Y=MJQnnKidBUVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 17/67] target/arm: Implement
 SVE Index Generation Group
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
>  target/arm/helper-sve.h    |  5 ++++
>  target/arm/sve_helper.c    | 40 +++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 14 ++++++++++
>  4 files changed, 126 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
