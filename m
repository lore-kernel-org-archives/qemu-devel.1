Received: from eggs.gnu.org ([2001:4830:134:3::10]:48572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUacR-0004TE-2x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUacQ-0001j7-AF
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:56:47 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUacQ-0001iv-3e
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:56:46 -0500
Received: by mail-ua0-x22a.google.com with SMTP id y9so62791614uae.2
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:56:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 14:56:24 +0000
Message-ID: <CAFEAcA85rz2M1cZSEu4XwPjhwL5k-yjyXEWskUw1Z1cmw0wvvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/17] virtio, vhost, pc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 January 2017 at 21:09, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 23eb9e6b6d5315171cc15969bbc755f258004df0:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-16' into staging (2017-01-17 13:53:50 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 2943b53f682f54548e7ddcf2ebb6c6d12d8dc821:
>
>   virtio: force VIRTIO_F_IOMMU_PLATFORM (2017-01-19 23:00:31 +0200)
>
> ----------------------------------------------------------------
> virtio, vhost, pc: fixes, features
>
> writeable fw cfg blobs which will be used for guest to host
> communication
> fixes and cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
