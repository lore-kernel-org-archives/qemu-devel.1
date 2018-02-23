Received: from eggs.gnu.org ([2001:4830:134:3::10]:47509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGX8-0003Z9-KJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGX7-0002Od-Lt
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:18 -0500
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:42631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGX7-0002Ml-Er
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:17 -0500
Received: by mail-pl0-x22a.google.com with SMTP id 31so5188111ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:49:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-40-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 16:48:38 +0000
Message-ID: <CAFEAcA-98xW_JP33Cv+A+WxDNVm79jay8Dm-km5LrhPJkQOCvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 39/67] target/arm: Implement SVE
 Predicate Count Group
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
>  target/arm/helper-sve.h    |   2 +
>  target/arm/sve_helper.c    |  14 ++++++
>  target/arm/translate-sve.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  27 +++++++++++
>  4 files changed, 159 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
