Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftGO6-0000vp-JH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 14:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftGO5-0001Ba-KO
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 14:00:46 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftGO5-0001Ae-9I
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 14:00:45 -0400
Received: by mail-oi0-x241.google.com with SMTP id l202-v6so9862742oig.7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 11:00:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180822144340.91828-1-groug@kaod.org>
References: <20180822144340.91828-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 19:00:23 +0100
Message-ID: <CAFEAcA8uyE0PAbarY=fb_JpfN+MYLnWU0zZ7Yqx5GUSPTJ-0qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] 9p patches 2018-08-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2018 at 15:43, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to adbffc2074754aff8d806843d9e83443590ce5e0:
>
>   fsdev: fix compilation with VIRTIO but not VIRTIO_9P (2018-08-22 12:21:13 +0200)
>
> ----------------------------------------------------------------
> Just a build fix that I had queued during soft freeze.
>
> ----------------------------------------------------------------
> Paolo Bonzini (1):
>       fsdev: fix compilation with VIRTIO but not VIRTIO_9P
>
>  fsdev/Makefile.objs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> --

Applied, thanks.

-- PMM
