Received: from eggs.gnu.org ([2001:4830:134:3::10]:46655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D3A-00050a-EP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D39-0006IQ-NB
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:48:00 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:43415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5D39-0006IA-Gk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:47:59 -0400
Received: by mail-wr0-x22d.google.com with SMTP id p46so8799255wrb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:47:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 16:47:37 +0100
Message-ID: <CAFEAcA9z4WzcaETB+_L0juV+H2qqSWvutqukwUnw5sSW5gz=kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/29] Misc patches for 2017-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 October 2017 at 17:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit a0b261db8c030813e30a39eae47359ac2a37f7e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2017-10-12 10:02:09 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3da023b5827543ee4c022986ea2ad9d1274410b2:
>
>   scsi: reject configurations with logical block size > physical block size (2017-10-18 11:56:14 +0200)
>
> ----------------------------------------------------------------
> * TCG 8-byte atomic accesses bugfix (Andrew)
> * Report disk rotation rate (Daniel)
> * Report invalid scsi-disk block size configuration (Mark)
> * KVM and memory API MemoryListener fixes (David, Maxime, Peter Xu)
> * x86 CPU hotplug crash fix (Igor)
> * Load/store API documentation (Peter Maydell)
> * Small fixes by myself and Thomas
> * qdev DEVICE_DELETED deferral (Michael)
>

Applied, thanks.

-- PMM
