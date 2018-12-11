Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk3Y-0007tm-Ny
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk3Y-0006ST-3r
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:34:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWk3X-0006Qm-Mo
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:34:44 -0500
Received: by mail-oi1-x244.google.com with SMTP id t204so12309306oie.7
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-11-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:34:30 +0000
Message-ID: <CAFEAcA-=3MWWhhjTpq22OGYqPdg=pb=z8DsR07geDzhodRHNeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/26] target/arm: Add new_pc argument to
 helper_exception_return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h    |  2 +-
>  target/arm/helper-a64.c    | 10 +++++-----
>  target/arm/translate-a64.c |  7 ++++++-
>  3 files changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
