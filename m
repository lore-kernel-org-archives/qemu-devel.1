Received: from eggs.gnu.org ([2001:4830:134:3::10]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOjeH-0001Yz-3I
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOjeG-00012K-8m
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:59:17 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:38079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOjeG-00011f-3y
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:59:16 -0400
Received: by mail-ot0-x233.google.com with SMTP id n3-v6so29156286ota.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:59:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1805311206230.23991@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805311206230.23991@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 13:58:54 +0100
Message-ID: <CAFEAcA-S9452xtRnmDMwdOY7Z2oDNDGrRjhaNrHP4Ume8mqAWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] xen-20180531-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, QEMU Developers <qemu-devel@nongnu.org>

On 31 May 2018 at 20:08, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a97:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180531-1' into staging (2018-05-31 17:00:55 +0100)
>
> are available in the git repository at:
>
>
>   http://xenbits.xenproject.org/git-http/people/sstabellini/qemu-dm.git tags/xen-20180531-tag
>
> for you to fetch changes up to dfb6578d69d60e464be36dafed9741dcfd73d2cf:
>
>   xen-hvm: stop faking I/O to access PCI config space (2018-05-31 12:05:01 -0700)
>
> ----------------------------------------------------------------
> Xen 2018/05/31
>
> ----------------------------------------------------------------
> Igor Druzhinin (1):
>       xen/hvm: correct reporting of modified memory under physmap during migration
>
> Paul Durrant (2):
>       xen-hvm: try to use xenforeignmemory_map_resource() to map ioreq pages
>       xen-hvm: stop faking I/O to access PCI config space

Applied, thanks.

-- PMM
