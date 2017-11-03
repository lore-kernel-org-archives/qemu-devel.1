Received: from eggs.gnu.org ([2001:4830:134:3::10]:39548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAYtV-0005eG-SR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAYtV-0007uw-2p
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:08:09 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:53017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAYtU-0007ub-S4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:08:09 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t139so400920wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 03:08:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171103084046.12821-1-richard.henderson@linaro.org>
References: <20171103084046.12821-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 10:07:47 +0000
Message-ID: <CAFEAcA81u=fYXZFWRzAmcB5a4RX2Y5+ZD3LMwcAcHsH-g2dxNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] TCG queued patches
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

On 3 November 2017 at 08:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Two bug fixes this time.
>
>
> r~
>
>
> The following changes since commit 094611b426b3b532a3ec72256cb4e958149269d3:
>
>   oslib-posix: Use sysctl(2) call to resolve exec_dir on NetBSD (2017-11-02 16:19:34 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171103
>
> for you to fetch changes up to 426eeecdf5d9cf1695a53c08f46394f8e5351750:
>
>   cpu-exec: Exit exclusive region on longjmp from step_atomic (2017-11-03 09:34:21 +0100)
>
> ----------------------------------------------------------------
> Queued tcg patches
>
> ----------------------------------------------------------------
> Peter Maydell (1):
>       cpu-exec: Exit exclusive region on longjmp from step_atomic
>
> Richard Henderson (2):
>       tcg: Allow constant pool entries in the prologue
>       tcg/s390x: Use constant pool for prologue

Applied, thanks.

-- PMM
