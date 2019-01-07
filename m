Received: from eggs.gnu.org ([209.51.188.92]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTSL-0000QP-VK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTSL-00072L-As
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:52:33 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggTSL-0006tn-4l
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:52:33 -0500
Received: by mail-oi1-x241.google.com with SMTP id c206so95116oib.0
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-21-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 11:52:19 +0000
Message-ID: <CAFEAcA9BenWf4bxAY-fikywDZhaAA6X-apD2NaHvSeb8vEpRPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 20/27] target/arm: Implement pauth_strip
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Stripping out the authentication data does not require any crypto,
> it merely requires the virtual address parameters.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
