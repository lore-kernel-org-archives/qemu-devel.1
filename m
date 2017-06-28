Received: from eggs.gnu.org ([2001:4830:134:3::10]:46925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQCOL-0001ti-SP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQCOL-0000kq-21
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:48:21 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dQCOK-0000jJ-RZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:48:20 -0400
Received: by mail-wm0-x235.google.com with SMTP id i127so57669895wma.0
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 05:48:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170628122041.13558-1-stefanha@redhat.com>
References: <20170628122041.13558-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Jun 2017 13:48:18 +0100
Message-ID: <CAJSP0QV7SMOZNAEtXFvqx6XTE0Kvcf-mz-Z=89qOszD67wJzpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Jun 28, 2017 at 1:20 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 577caa2672ccde7352fda3ef17e44993de862f0e:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/mmio-exec-v2.for-upstream' into staging (2017-06-27 16:56:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 439778e6b4a20c8fe6a6a92a17013b09c4ae55d0:
>
>   virtio-pci: use ioeventfd even when KVM is disabled (2017-06-28 13:18:53 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (2):
>   virtio-blk: trace vdev so devices can be distinguished
>   virtio-pci: use ioeventfd even when KVM is disabled

NACK

I missed the mail discussing the virtio-scsi-test assertion failure
caused by "virtio-pci: use ioeventfd even when KVM is disabled".

Stefan
