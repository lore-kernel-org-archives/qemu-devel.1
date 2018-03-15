Received: from eggs.gnu.org ([2001:4830:134:3::10]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewPgX-0002XK-MM
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewPgW-00037K-SW
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:00:33 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewPgW-000366-Go
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:00:32 -0400
Received: by mail-ot0-x241.google.com with SMTP id g97-v6so6237089otg.13
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 03:00:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313122956.21442-1-jcody@redhat.com>
References: <20180313122956.21442-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 10:00:11 +0000
Message-ID: <CAFEAcA8mBBAqKKCcA1O4=JjGcLpxBSZC4aBgv+77oTLu41NRPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 March 2018 at 12:29, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 834eddf22ec762839b724538c7be1d1d3b2d9d=
3b:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-13 10:49:02 +0000)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 44acd46f60ce6f16d369cd443e77949deca56a2c:
>
>   block: include original filename when reporting invalid URIs (2018-03-1=
3 08:06:55 -0400)
>
> ----------------------------------------------------------------
> Block patch
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (1):
>   block: include original filename when reporting invalid URIs
>
>  block/gluster.c  | 2 +-
>  block/sheepdog.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Applied, thanks.

-- PMM
