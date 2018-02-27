Received: from eggs.gnu.org ([2001:4830:134:3::10]:44351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfnU-0002QZ-DE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfnT-0007eB-Io
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:00:00 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfnT-0007dr-EC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:59:59 -0500
Received: by mail-ot0-x22c.google.com with SMTP id t2so3842596otj.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:59:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-51-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:59:38 +0000
Message-ID: <CAFEAcA8R4AXDfj8rwM8Cnw8G=4aDuFbdwFRrGx4g5s-GRWw4qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 50/67] target/arm: Implement
 SVE Floating Point Accumulating Reduction Group
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  7 ++++++
>  target/arm/sve_helper.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 42 ++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  5 +++++
>  4 files changed, 110 insertions(+)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
