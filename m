Received: from eggs.gnu.org ([2001:4830:134:3::10]:53964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePnw4-0007he-4O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePnw3-0004Bh-4t
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:13:48 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:38108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePnw3-0004B9-02
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:13:47 -0500
Received: by mail-ot0-x234.google.com with SMTP id p3so7486666oti.5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 03:13:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 11:13:25 +0000
Message-ID: <CAFEAcA-wFTmSxjguddLjavRhf_h1=KAu26ENbH6OSEobBM5QOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] xen-20171214-tag
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

On 15 December 2017 at 00:27, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the git repository at:
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20171214-tag
>
> for you to fetch changes up to 2e63eb2becc228232f12a1ea30a91b2aa8c5cecd:
>
>   xen/pt: Set is_express to avoid out-of-bounds write (2017-12-14 16:11:53 -0800)
>
> ----------------------------------------------------------------
> Xen 2017/12/14
>
> ----------------------------------------------------------------
> Owen Smith (4):
>       ui: generate qcode to linux mappings
>       xenfb: Use Input Handlers directly
>       xenfb: Add [feature|request]-raw-pointer
>       xenfb: activate input handlers for raw pointer devices
>
> Paul Durrant (1):
>       xen-disk: use an IOThread per instance
>
> Simon Gaiser (1):
>       xen/pt: Set is_express to avoid out-of-bounds write

Applied, thanks.

-- PMM
