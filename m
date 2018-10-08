Received: from eggs.gnu.org ([2001:4830:134:3::10]:45907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9W5Q-0000yJ-H8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9VtF-00069h-Pj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:48:06 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:36448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9VtF-000697-5x
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:48:05 -0400
Received: by mail-ot1-x32a.google.com with SMTP id k5so6876462ote.3
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 06:48:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005180201.11387-1-richard.henderson@linaro.org>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 14:47:43 +0100
Message-ID: <CAFEAcA8FiKkkXXOyLYC09krStSS-b8zhADs2S39QT18W1JVq+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] softfloat queue
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

On 5 October 2018 at 19:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit ae7a4c0a4604bcfed40170db6cca576c44d872a2:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181004' into staging (2018-10-05 16:05:06 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-fpu-20181005
>
> for you to fetch changes up to 27ae5109a2ba8b6b679cce3e03e16570a34390a0:
>
>   softfloat: Specialize udiv_qrnnd for ppc64 (2018-10-05 12:57:41 -0500)
>
> ----------------------------------------------------------------
> Testing infrastructure for softfpu (not run by default).
> Drop countLeadingZeros.
> Fix div_floats.
> Add udiv_qrnnd specializations for x86_64, s390x, ppc64 hosts.
>
> ----------------------------------------------------------------

Applied, thanks.

I guess we should mirror the new submodules on git.qemu.org.

-- PMM
