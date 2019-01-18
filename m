Received: from eggs.gnu.org ([209.51.188.92]:42225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSaO-0008At-6k
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSaN-0008Lg-JD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:45:20 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkSaM-0008Bc-97
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:45:19 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so14148506otj.2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-20-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 11:45:02 +0000
Message-ID: <CAFEAcA-o-R6PQpkFkFVOUPgJ68NGG2QO51YKe0N-FrHXW8J0gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 19/31] target/arm: Merge TBFLAG_AA_TB{0,
 1} to TBII
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
> We will shortly want to talk about TBI as it relates to data.
> Passing around a pair of variables is less convenient than a
> single variable.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(apologies for the content-free other email: mail client misfire.)

thanks
-- PMM
