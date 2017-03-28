Received: from eggs.gnu.org ([2001:4830:134:3::10]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csptC-0004Hf-BX
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cspt6-0001BS-Pz
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:06:18 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cspt6-0001BI-Jc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:06:12 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w11so84074924wrc.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 05:06:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 13:05:50 +0100
Message-ID: <CAFEAcA99nRzad7zTo8-ao4+5h6hpFsgbo1409tCSrezmGcCfyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] MTTCG fixes for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 March 2017 at 12:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit ea2afcf5b6727a577cf561fd8fe0d8c397ecc9=
27:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-03-24 14:14:18 +0000)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-mttcg-fixups-for-rc2-2803=
17-1
>
> for you to fetch changes up to 5b12c163c830081cbb78e2de3b42c5fe1b73e74e:
>
>   replay/replay.c: bump REPLAY_VERSION (2017-03-28 10:52:50 +0100)
>
> ----------------------------------------------------------------
> MTTCG regression fixes for rc2
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (5):
>       user-exec: handle synchronous signals from QEMU gracefully
>       bsd-user: align use of mmap_lock to that of linux-user
>       ui/console: ensure do_safe_dpy_refresh holds BQL
>       ui/console: use exclusive mechanism directly
>       replay/replay.c: bump REPLAY_VERSION
>
> Pranith Kumar (1):
>       tcg: Add a new line after incompatibility warnin

Applied, thanks.

-- PMM
