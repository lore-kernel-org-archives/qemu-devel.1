Received: from eggs.gnu.org ([209.51.188.92]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqfBP-0005JF-Rv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqf0M-0007uW-SI
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:13:48 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqf0G-0007mx-4B
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:13:42 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so1460otk.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201195404.30486-1-richard.henderson@linaro.org>
In-Reply-To: <20190201195404.30486-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:13:20 +0000
Message-ID: <CAFEAcA9Rzx0SK9O0H3Qu+KxGtNCUC9P9QuYrDoPYTnfa2PDJgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] target/arm: Complete ARMv8.3-PAuth
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, 1 Feb 2019 at 19:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Most of the v1 patch set has been merged.
> Changes since v1:
>
>  * I've added the missing check against arg3 through arg5.
>  * I've removed the -O1 I had cribed from the MTE patch set.
>



Applied to target-arm.next, thanks.

-- PMM
