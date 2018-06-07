Received: from eggs.gnu.org ([2001:4830:134:3::10]:50743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQqh8-0004Rd-BQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQqh7-0006KV-NC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:54:58 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQqh7-0006K6-Hf
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:54:57 -0400
Received: by mail-oi0-x231.google.com with SMTP id t22-v6so7899402oih.6
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 01:54:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-18-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 09:54:36 +0100
Message-ID: <CAFEAcA_vvK2M3LZ9vdcbDX5qFfeRAnbAnSoyWencVAXygJq1rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 17/18] target/arm: Implement SVE
 Integer Wide Immediate - Unpredicated Group
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
>  target/arm/helper-sve.h    |  25 +++++++
>  target/arm/sve_helper.c    |  41 +++++++++++
>  target/arm/translate-sve.c | 144 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  26 +++++++
>  4 files changed, 236 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
