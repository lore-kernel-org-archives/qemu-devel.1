Received: from eggs.gnu.org ([2001:4830:134:3::10]:58422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQxmu-0000vF-W6
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQxmu-0000WI-9z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:52:37 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:33533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQxmu-0000W5-1J
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:52:36 -0500
Received: by mail-ua0-x235.google.com with SMTP id i68so384305889uad.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 06:52:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 14:52:14 +0000
Message-ID: <CAFEAcA-=gvkq6711ZKH5W-gOoGM569XUFTj-raLeCiMrtpbCtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/41] virtio, vhost, pc: fixes, features
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

On 10 January 2017 at 05:39, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 77424a452abe5f941d8cd81f1e85f42bca31c9ef:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-01-09 15:30:45 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 987da7be996e63c294dc6485acb1c37af7696257:
>
>   acpi-test: update expected files (2017-01-10 07:06:42 +0200)
>
> ----------------------------------------------------------------
> virtio, vhost, pc: fixes, features
>
> beginnings of iotlb support for vhost
> acpi hotplug rework
> vhost net tx flush on link down
> passing mtu to guests
> hotplug for virtio crypto
> fixes and cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
