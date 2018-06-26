Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXmnW-0008AY-0g
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXmnR-0003UF-VM
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:10:13 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXmnR-0003Tj-PN
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:10:09 -0400
Received: by mail-ot0-x243.google.com with SMTP id w16-v6so10083622otk.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 05:10:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-26-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 13:09:48 +0100
Message-ID: <CAFEAcA8aw5+swB4JOGQ=4Zg_jbWZCRnqdAsD1UF+=WsPWSGm4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 25/35] target/arm: Implement SVE
 floating-point round to integral value
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
>  target/arm/helper-sve.h    | 14 +++++++
>  target/arm/sve_helper.c    |  8 ++++
>  target/arm/translate-sve.c | 77 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  9 +++++
>  4 files changed, 108 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
