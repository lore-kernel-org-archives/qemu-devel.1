Received: from eggs.gnu.org ([2001:4830:134:3::10]:36900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhz1P-0005xC-3l
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhz1O-0008CW-6E
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:14:43 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhz1N-0008Bf-VT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:14:42 -0400
Received: by mail-oi0-x244.google.com with SMTP id i12-v6so8154627oik.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 08:14:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724142331.14669-1-stefanha@redhat.com>
References: <20180724142331.14669-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 16:14:20 +0100
Message-ID: <CAFEAcA9imzdF+zrMU+9WVtiXvEFvNJj0+N-nc7ug1Ov9aPNKLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 24 July 2018 at 15:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 768cef2974fb1fa30dd188b043ea737e13fea477:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-07-24 10:37:52 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 042b757cc77c9580b99ef2781cfb0a2d1bf495a6:
>
>   block/file-posix: add bdrv_attach_aio_context callback for host dev and cdrom (2018-07-24 14:27:41 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Regression fix for host block devices with the file-posix driver when aio=native is in use.
>
> ----------------------------------------------------------------
>
> Nishanth Aravamudan (1):
>   block/file-posix: add bdrv_attach_aio_context callback for host dev
>     and cdrom
>
>  block/file-posix.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Applied, thanks.

-- PMM
