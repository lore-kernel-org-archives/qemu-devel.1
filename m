Received: from eggs.gnu.org ([2001:4830:134:3::10]:49609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFey-0001ex-Qs
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFey-0006T9-2b
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:53:20 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:44969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epFex-0006Sf-T7
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:53:20 -0500
Received: by mail-pl0-x22e.google.com with SMTP id w21so5105140plp.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:53:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-35-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:52:58 +0000
Message-ID: <CAFEAcA8MSeNMuUNdG2HkLkd-08QYCeFSWNcxtd67pGRrN00_ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 34/67] target/arm: Implement
 SVE vector splice (predicated)
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
>  target/arm/helper-sve.h    |  2 ++
>  target/arm/sve_helper.c    | 37 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 10 ++++++++++
>  target/arm/sve.decode      |  3 +++
>  4 files changed, 52 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
