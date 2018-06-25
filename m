Received: from eggs.gnu.org ([2001:4830:134:3::10]:36735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXT1k-00079u-Ti
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXT1d-0007Vr-93
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:03:36 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:40781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXT1d-0007VV-3i
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:03:29 -0400
Received: by mail-ot0-x234.google.com with SMTP id w9-v6so15390981otj.7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:03:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-4-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:03:08 +0100
Message-ID: <CAFEAcA87mb7aaSGFmuZGGw_PBa2q8N89acQuaqj_XbpNzB4qvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 03/35] target/arm: Implement SVE Memory
 Contiguous Store Group
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
>  target/arm/helper-sve.h    |  29 +++++
>  target/arm/sve_helper.c    | 211 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  65 ++++++++++++
>  target/arm/sve.decode      |  38 +++++++
>  4 files changed, 343 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
