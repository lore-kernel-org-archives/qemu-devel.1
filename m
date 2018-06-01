Received: from eggs.gnu.org ([2001:4830:134:3::10]:47624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOlMR-0003uY-Hr
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOlMO-0001WG-FD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:48:59 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:56518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOlMO-0001VX-7v
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:48:56 -0400
Date: Fri, 1 Jun 2018 16:48:53 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180601144853.3o4pinpkcotfj2dd@var.youpi.perso.aquilenet.fr>
References: <20180601135610.16149-1-samuel.thibault@ens-lyon.org>
	<a1f89a39-dfb8-deb6-565a-49bb14d83036@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f89a39-dfb8-deb6-565a-49bb14d83036@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9 v2] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@redhat.com, jan.kiszka@siemens.com

Eric Blake, le ven. 01 juin 2018 09:45:25 -0500, a ecrit:
> On 06/01/2018 08:56 AM, Samuel Thibault wrote:
> > The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a97:
> > 
> >    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180531-1' into staging (2018-05-31 17:00:55 +0100)
> > 
> > are available in the Git repository at:
> > 
> >    https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> > 
> > for you to fetch changes up to 47335eeea8f1d14b7c6a1dd585a25a9166721168:
> > 
> >    slirp/ncsi: add checksum support (2018-05-31 21:19:24 +0200)
> 
> As long as you're respinning a v2, do you want a v3 that fixes the issue I
> pointed out on 1/9 (s/2.12/3.0/)?

Too late :) Anyway, I'll send a PR as soon as the MAINTAINER patch I
sent on

http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg07244.html

gets reviewed.

Samuel
