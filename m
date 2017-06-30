Received: from eggs.gnu.org ([2001:4830:134:3::10]:54835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQwS1-0001kL-GE
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQwS0-0002QO-O9
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:59:13 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQwS0-0002PF-H7
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:59:12 -0400
Received: by mail-wr0-x22f.google.com with SMTP id c11so204907332wrc.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:59:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630114635.9286-1-stefanha@redhat.com>
References: <20170630114635.9286-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 14:58:50 +0100
Message-ID: <CAFEAcA8TmmM9P1h-op4MksWY1aJz6fd5Khr+G9eEqyNf-HB2Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 June 2017 at 12:46, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 464588675455afda2899e20a0b120e4075de50c7:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170627-tag' into staging (2017-06-29 11:45:01 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to c324fd0a39cee43c13f6d1fb34f74fc5e2fb007b:
>
>   virtio-pci: use ioeventfd even when KVM is disabled (2017-06-30 11:03:45 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (7):
>   virtio-blk: trace vdev so devices can be distinguished
>   libqos: fix typo in virtio.h QVirtQueue->used comment
>   libqos: add virtio used ring support
>   tests: fix virtio-scsi-test ISR dependence
>   tests: fix virtio-blk-test ISR dependence
>   tests: fix virtio-net-test ISR dependence
>   virtio-pci: use ioeventfd even when KVM is disabled

Applied, thanks.

-- PMM
