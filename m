Received: from eggs.gnu.org ([2001:4830:134:3::10]:44528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPsyK-0002YY-He
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPsyJ-0006tc-NC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:08:44 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPsyJ-0006tK-9Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:08:43 -0400
Received: by mail-ot0-x22c.google.com with SMTP id q17-v6so27996489otg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 10:08:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-10-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 18:08:22 +0100
Message-ID: <CAFEAcA9VaX2ZKdGQZ3oQnRR-sD1EswrQPPBPRCiH8g9P20428g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 09/18] target/arm: Implement SVE vector
 splice (predicated)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  2 ++
>  target/arm/sve_helper.c    | 37 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 13 +++++++++++++
>  target/arm/sve.decode      |  3 +++
>  4 files changed, 55 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
