Received: from eggs.gnu.org ([209.51.188.92]:50068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7dG-0004Ar-7G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7dF-0005XY-D1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:51:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7dF-0005X7-7K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:51:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id t189so5476720oih.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-35-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:51:37 +0100
Message-ID: <CAFEAcA_KM-rLtPvrHNNfF=FO91fBZbDD2J2j9kAqWwNC6TAQ6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 34/36] cpu: Remove CPU_COMMON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This macro is now always empty, so remove it.  This leaves the
> entire contents of CPUArchState under the control of the guest
> architecture.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
