Received: from eggs.gnu.org ([2001:4830:134:3::10]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emN9J-0003H9-VL
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emN9J-0006tu-4W
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:16:45 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emN9I-0006ta-VH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:16:45 -0500
Received: by mail-oi0-x243.google.com with SMTP id r144so320526oie.6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:16:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215094210.27770-1-stefanha@redhat.com>
References: <20180215094210.27770-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 17:16:22 +0000
Message-ID: <CAFEAcA8eJ0USKnZAhd72CcUGcPt9qRC3KmOdY6OZ90FHAG5EBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 15 February 2018 at 09:42, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea2=
17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-02-13 18:24:08 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to d2f668b74907cbd96d9df0774971768ed06de2f0:
>
>   misc: fix spelling (2018-02-15 09:39:49 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Dropped Fam's git-publish series because there is still ongoing discus=
sion
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   misc: fix spelling
>
> Stefan Hajnoczi (1):
>   vl: pause vcpus before stopping iothreads
>
> Wolfgang Bumiller (1):
>   ratelimit: don't align wait time with slices
>
>  include/qemu/ratelimit.h   | 11 +++++------
>  util/qemu-coroutine-lock.c |  2 +-
>  vl.c                       | 12 ++++++++++--
>  3 files changed, 16 insertions(+), 9 deletions(-)

Applied, thanks.

-- PMM
