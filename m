Received: from eggs.gnu.org ([2001:4830:134:3::10]:42048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDZ5m-00026p-Pg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDZ5k-00062G-Kb
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:01:46 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:47093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDZ5k-0005Yh-5l
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:01:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id k64-v6so27468519oia.13
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 11:01:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019060656.7968-1-richard.henderson@linaro.org>
References: <20181019060656.7968-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 19:01:14 +0100
Message-ID: <CAFEAcA_gpNi5oo-L5HurEm9z3fXq8H28c03Z2jTrgRsGBrG9+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/21] tcg patch queue
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

On 19 October 2018 at 07:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since v1:
>   * Added QEMU_ERROR to wrap __attribute__((error)) -- patch 12.
>
>
> r~
>
>
> The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20181018
>
> for you to fetch changes up to 403f290c0603f35f2d09c982bf5549b6d0803ec1:
>
>   cputlb: read CPUTLBEntry.addr_write atomically (2018-10-18 19:46:53 -0700)
>
> ----------------------------------------------------------------
> Queued tcg patches.
>

Applied, thanks.

-- PMM
