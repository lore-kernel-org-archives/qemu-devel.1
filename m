Received: from eggs.gnu.org ([2001:4830:134:3::10]:60316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyLbV-0005Tc-Tm
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyLbV-0001ER-0a
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:21 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyLbU-0001EC-RK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:03:20 -0400
Received: by mail-ot0-x244.google.com with SMTP id 95-v6so2743710ote.5
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:03:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521556868-37974-1-git-send-email-mst@redhat.com>
References: <1521556868-37974-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 18:02:59 +0000
Message-ID: <CAFEAcA-E28itBd5z0FvAA05R_NH8J7QBhT0KiXWaJ8ZWNNukpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/51] virtio, vhost, pci, pc: features,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 20 March 2018 at 14:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> Note: only patch 39/51 is attached.
> The rest are unchanged from v2.
>
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1dc61e7b37d339c42ec9bd7a7eec1ef2c22f351c:
>
>   postcopy shared docs (2018-03-20 16:40:37 +0200)
>
> ----------------------------------------------------------------
> virtio,vhost,pci,pc: features, cleanups
>
> SRAT tables for DIMM devices
> new virtio net flags for speed/duplex
> post-copy migration support in vhost
> cleanups in pci
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
