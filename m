Received: from eggs.gnu.org ([2001:4830:134:3::10]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXnqg-00025m-Co
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXnqf-00006h-Kl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:17:34 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXnqf-00006S-En
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:17:33 -0400
Received: by mail-ot0-x244.google.com with SMTP id h6-v6so19000133otj.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 06:17:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-29-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 14:17:12 +0100
Message-ID: <CAFEAcA8FK_a3kdTtqQhebcwkXj2hyBOKJbU9v-p6N-eRSMfYrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 28/35] target/arm: Implement SVE
 floating-point complex add
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
>  target/arm/helper-sve.h    |   7 +++
>  target/arm/sve_helper.c    | 100 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  24 +++++++++
>  target/arm/sve.decode      |   4 ++
>  4 files changed, 135 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
