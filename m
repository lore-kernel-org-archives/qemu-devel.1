Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtDG8-0005Gj-6X
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 09:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtDG7-0001e1-A3
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 09:35:48 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:45929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtDG7-0001dA-26
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 09:35:47 -0400
Received: by mail-wm0-x22b.google.com with SMTP id g206so13650884wme.0
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 06:35:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915173950.21404-1-stefanha@redhat.com>
References: <20170915173950.21404-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 14:35:22 +0100
Message-ID: <CAFEAcA-zF-x4PtvthQg5y1DrbEEHS7-Y+wAUgA3m41YtwyCCnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 September 2017 at 18:39, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 3dabde1128b671f36ac6cb36b97b2731399644=
20:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' =
into staging (2017-09-14 16:33:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to f99b38fc7c1bdf2dcc5e316478281c35b8c60f79:
>
>   trace: Immediately apply per-vCPU state changes if a vCPU is being crea=
ted (2017-09-15 14:25:22 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Llu=C3=ADs Vilanova (1):
>   trace: Immediately apply per-vCPU state changes if a vCPU is being
>     created
>
>  trace/control-target.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
