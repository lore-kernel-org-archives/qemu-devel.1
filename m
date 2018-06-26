Received: from eggs.gnu.org ([2001:4830:134:3::10]:33573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXoJa-0002Qy-BP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXoJZ-0005IR-JV
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:47:26 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXoJZ-0005IH-6H
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:47:25 -0400
Received: by mail-ot0-x22d.google.com with SMTP id a6-v6so4554214otf.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 06:47:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-33-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 14:47:04 +0100
Message-ID: <CAFEAcA95mu4H8SZ0MMp3b=47xGQvoh2mx1gzMGTLgY5Qeyq=zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 32/35] target/arm: Implement SVE dot
 product (vectors)
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        |  5 +++
>  target/arm/translate-sve.c | 17 ++++++++++
>  target/arm/vec_helper.c    | 67 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  3 ++
>  4 files changed, 92 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
