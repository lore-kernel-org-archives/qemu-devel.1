Received: from eggs.gnu.org ([2001:4830:134:3::10]:40948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7JsP-0001Pu-Cc
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Jp2-00080N-G9
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:30:42 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7Jp0-0007yS-Ll
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:30:40 -0400
Received: by mail-oi1-x244.google.com with SMTP id j68-v6so1323811oib.7
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 05:30:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180927211322.16118-1-richard.henderson@linaro.org>
References: <20180927211322.16118-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 13:30:10 +0100
Message-ID: <CAFEAcA8zsd21+5va-ApormhvSrnZ18Ygs4w=eH9rkRr7nf5inQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/9] target/arm: Rely on id regs instead
 of features
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

On 27 September 2018 at 22:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
> There are more feature bits that could be converted, but I thought
> I should show the work to this point to get feedback.
>
> This is the "v2" as compared to
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg01849.html

So having written the code both ways round, which do you think
works out nicer? (or at least least-worst :-))

thanks
-- PMM
