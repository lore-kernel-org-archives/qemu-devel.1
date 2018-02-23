Received: from eggs.gnu.org ([2001:4830:134:3::10]:40971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFE2-0003gj-VV
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFE2-00048O-31
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:25:30 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:44729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epFE1-00047w-Ss
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:25:30 -0500
Received: by mail-pg0-x22f.google.com with SMTP id l4so3469070pgp.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:25:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-31-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:25:08 +0000
Message-ID: <CAFEAcA8AEDg=ZoTgU6E-R3ytBzaSKcEpOhAha8miW4VVcYha5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 30/67] target/arm: Implement
 SVE compress active elements
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  3 +++
>  target/arm/sve_helper.c    | 34 ++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 12 ++++++++++++
>  target/arm/sve.decode      |  6 ++++++
>  4 files changed, 55 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
