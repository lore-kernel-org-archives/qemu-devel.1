Received: from eggs.gnu.org ([2001:4830:134:3::10]:51826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e8MxT-00021n-L0
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e8MxS-0008Ex-PX
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 04:59:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e8MxS-0008EC-HS
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 04:59:10 -0400
Received: by mail-wm0-x242.google.com with SMTP id n74so3851686wmi.1
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 01:59:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710261556510.3086@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710261556510.3086@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Oct 2017 09:58:48 +0100
Message-ID: <CAFEAcA_Hn97_PeXZ+cdF3wQ9_5ZOWEfAwvD3g1YWqXEAt3cS1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] xen-20171026-tag
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

On 26 October 2017 at 23:59, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 325a084c1ebccb265a3c8f1dd092ffbbfb448a00:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-10-24-1' into staging (2017-10-26 09:20:11 +0100)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20171026-tag
>
> for you to fetch changes up to 7cdcca725b6bfc96634c15e3f74ae4b148cf9c40:
>
>   xen: Log errno rather than return value (2017-10-26 14:26:48 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/10/26
>
> ----------------------------------------------------------------
> Juergen Gross (2):
>       xen: add a global indicator for grant copy being available
>       xen: dont try setting max grants multiple times
>
> Ross Lagerwall (1):
>       xen: Log errno rather than return value

Applied, thanks.

-- PMM
