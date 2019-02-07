Received: from eggs.gnu.org ([209.51.188.92]:51987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnXf-0006uB-W8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnXd-0007V8-MP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:32:51 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grnXa-0007TS-T2
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:32:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id s13so1186894otq.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-9-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:32:30 +0000
Message-ID: <CAFEAcA-=WDNsZaDCg3X_2ZZReiqZLBLaS2RBJuJ0_mfoTv-erw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/17] target/arm: Implement the GMI
 instruction
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

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h    | 1 +
>  target/arm/mte_helper.c    | 6 ++++++
>  target/arm/translate-a64.c | 6 ++++++
>  3 files changed, 13 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
