Received: from eggs.gnu.org ([2001:4830:134:3::10]:41121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8SS-0006Yi-7g
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8SQ-0002gI-7M
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:22:02 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:46465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb8SQ-0002ft-1y
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:22:02 -0500
Received: by mail-ot0-x231.google.com with SMTP id t35so4585167otd.13
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:22:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-4-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 17:21:41 +0000
Message-ID: <CAFEAcA8cN02sum-gosD95ySmwF_ZAJY_znfJ-+vBQ8yMHX-=Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 03/11] target/arm: Decode aa64 armv8.1
 three same extra
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

On 18 December 2017 at 17:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h         |  9 +++++
>  target/arm/advsimd_helper.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
