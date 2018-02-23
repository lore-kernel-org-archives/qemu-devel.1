Received: from eggs.gnu.org ([2001:4830:134:3::10]:49909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epE3x-0000Ts-MI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epE3w-0007li-Q4
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:11:01 -0500
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:45689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epE3w-0007kG-Jj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:11:00 -0500
Received: by mail-pl0-x231.google.com with SMTP id v9-v6so2952931plp.12
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:11:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-25-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 14:10:38 +0000
Message-ID: <CAFEAcA-ZeLDLjii2A+BeVjg923DT=Skw3gQLp3eZvuLM0aYfNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 24/67] target/arm: Implement
 SVE Bitwise Immediate Group
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
>  target/arm/translate-sve.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 17 ++++++++++++++++
>  2 files changed, 67 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
