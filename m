Received: from eggs.gnu.org ([2001:4830:134:3::10]:39960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUrc-0002cj-8I
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUrW-0008Ph-Q7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:01:16 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXUrW-0008PY-Lf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:01:10 -0400
Received: by mail-ot0-x242.google.com with SMTP id w9-v6so15836817otj.7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-16-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 18:00:49 +0100
Message-ID: <CAFEAcA918gy6t9tAeEVbDsPS=uVCLecyfNaejAqe8Utt4VXewg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 15/35] target/arm: Implement SVE scatter
 store vector immediate
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
>  target/arm/translate-sve.c | 83 ++++++++++++++++++++++++++------------
>  target/arm/sve.decode      | 11 +++++
>  2 files changed, 69 insertions(+), 25 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
