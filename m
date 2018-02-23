Received: from eggs.gnu.org ([2001:4830:134:3::10]:57570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epG67-0001Xo-Ut
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:21:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epG67-0005Jk-6e
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:21:23 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:34839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epG66-0005JU-WE
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:21:23 -0500
Received: by mail-pf0-x231.google.com with SMTP id y186so3020397pfb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 08:21:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-36-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 16:21:01 +0000
Message-ID: <CAFEAcA8H6s-cVcq9aontUuV5E0xuB0StuPOa70skZ1N7W64RTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 35/67] target/arm: Implement
 SVE Select Vectors Group
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
>  target/arm/helper-sve.h    |  9 ++++++++
>  target/arm/sve_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  2 ++
>  target/arm/sve.decode      |  6 +++++
>  4 files changed, 72 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
