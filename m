Received: from eggs.gnu.org ([2001:4830:134:3::10]:54290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjDNM-0005uK-C9
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjDNL-0003SA-C5
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:09:40 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjDNL-0003Rn-5E
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:09:39 -0500
Received: by mail-wm0-x230.google.com with SMTP id n11so11267709wma.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 15:09:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1702281106420.5551@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1702281106420.5551@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 23:09:17 +0000
Message-ID: <CAFEAcA_MVSo9sxxRL9z7ukDz+r4EE3CTmW2GAU0F=48qeQxBwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] tags/xen-20170228-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 19:15, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 7d1730b7d9d8272a13245adfc9b0405e5a4bd0c2:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-02-28 16:22:41 +0000)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170228-tag
>
> for you to fetch changes up to daa33c52153df48ef0a7d06013f8ca6f24eff92f:
>
>   Add a new qmp command to do checkpoint, query xen replication status (2017-02-28 11:02:12 -0800)
>
> ----------------------------------------------------------------
> Xen 2017/02/28
>
> ----------------------------------------------------------------
> Zhang Chen (2):
>       Add a new qmp command to start/stop replication
>       Add a new qmp command to do checkpoint, query xen replication status
>

Applied, thanks.

-- PMM
