Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD7bR-0005fX-9X
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD7bP-0003Rc-Ap
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:40:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD7bO-0003Ec-Ku
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:40:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id w67so29557114ota.7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 05:40:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016224759.3158-1-richard.henderson@linaro.org>
References: <20181016224759.3158-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 13:40:01 +0100
Message-ID: <CAFEAcA8JPG_ktk5MFW6YMJ7VW1FV9_8FyW_N9enrw3mFajUgvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] target/hppa patch queue
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

On 16 October 2018 at 23:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20181016
>
> for you to fetch changes up to 5f538f75324ef69d624b5f71ab2c7f4e72a7d744:
>
>   target/hppa: Raise exception 26 on emulated hardware (2018-10-16 15:32:22 -0700)
>
> ----------------------------------------------------------------
> Queued hppa patch
>
> ----------------------------------------------------------------
> Helge Deller (1):
>       target/hppa: Raise exception 26 on emulated hardware
>
>  target/hppa/mem_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Applied, thanks.

-- PMM
