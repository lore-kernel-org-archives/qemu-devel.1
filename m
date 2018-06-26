Received: from eggs.gnu.org ([2001:4830:134:3::10]:49600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXl3j-00047P-KY
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXl3g-0001tr-HS
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:18:49 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXl3g-0001tj-Bs
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:18:48 -0400
Received: by mail-ot0-x231.google.com with SMTP id c15-v6so18445909otl.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 03:18:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-22-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 11:18:27 +0100
Message-ID: <CAFEAcA8E7eXvbUy8DVWbo8V2kB1=b74LEsiqpY58gK3SkYjRQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 21/35] target/arm: Implement SVE FP
 Compare with Zero Group
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
>  target/arm/helper-sve.h    | 42 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 43 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 43 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 10 +++++++++
>  4 files changed, 138 insertions(+)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
