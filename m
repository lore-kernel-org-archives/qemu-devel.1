Received: from eggs.gnu.org ([209.51.188.92]:46772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSpF-0003hx-Uc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSpF-0001SW-6u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:00:41 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkSpC-00012S-BG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:00:41 -0500
Received: by mail-ot1-x329.google.com with SMTP id s5so14133771oth.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 04:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-22-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 12:00:10 +0000
Message-ID: <CAFEAcA94HuXJCgHngy3bek9NFZY=k6ARg9zmu7yGzX0s1U+gqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 21/31] target/arm: Add
 aa64_va_parameters_both
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

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will want to check TBI for I and D simultaneously.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
