Received: from eggs.gnu.org ([2001:4830:134:3::10]:41392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTIw-0007jD-C9
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTIv-0005uh-HU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:21:22 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTIv-0005uQ-Bh
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:21:21 -0400
Received: by mail-ot0-x22c.google.com with SMTP id c15-v6so15484978otl.3
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:21:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-6-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:21:00 +0100
Message-ID: <CAFEAcA_tW_L9AfGx4MV0Mu+t-HNt-9uCo8iYoWGo6sLHut04qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 05/35] target/arm: Implement SVE integer
 convert to floating-point
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
>  target/arm/helper-sve.h    | 30 +++++++++++++
>  target/arm/sve_helper.c    | 38 ++++++++++++++++
>  target/arm/translate-sve.c | 90 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 22 ++++++++++
>  4 files changed, 180 insertions(+)



Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
