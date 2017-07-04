Received: from eggs.gnu.org ([2001:4830:134:3::10]:50765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSMaH-0005fw-Bz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSMaG-0003Qd-DI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:05:37 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dSMaG-0003Pl-6q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:05:36 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so82490657wmh.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 05:05:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2017 13:05:14 +0100
Message-ID: <CAFEAcA85GxUWwsOTXo1Gw4ThwDuNLHM0NG+opvDvyOGTYxevTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] pc, acpi, pci, virtio: fixes, cleanups,
 features, tests
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

On 3 July 2017 at 20:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit fd479c60f5766f7fb247ad146b9e3c33d03d2055:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170603' into staging (2017-07-03 09:54:32 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to d2f9ca94165b10c51d6d6cae5fe1cadf1ca42076:
>
>   i386/acpi: update expected acpi files (2017-07-03 22:42:36 +0300)
>
> ----------------------------------------------------------------
> pc, acpi, pci, virtio: fixes, cleanups, features, tests
>
> Some fixes and cleanups. New tests.
> Configurable tx queue size for virtio-net.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
