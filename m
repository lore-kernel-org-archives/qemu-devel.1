Received: from eggs.gnu.org ([209.51.188.92]:47024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7Pb-000674-8T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7Pa-0004eH-Ei
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:37:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7Pa-0004e0-AZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:37:42 -0400
Received: by mail-oi1-x243.google.com with SMTP id t184so5947544oie.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-30-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:37:30 +0100
Message-ID: <CAFEAcA8uZNvVgysf-b5y5qpfMXcNm8dGWcsaDydHMB7_nyNj6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 29/36] cpu: Move ENV_OFFSET to
 exec/gen-icount.h
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

On Thu, 28 Mar 2019 at 23:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that we have ArchCPU, we can define this generically,
> in the one place that needs it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
