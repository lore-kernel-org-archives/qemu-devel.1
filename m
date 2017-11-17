Received: from eggs.gnu.org ([2001:4830:134:3::10]:33837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFctk-00047h-9e
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFctj-0004Vj-Fh
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:25:20 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFctj-0004V1-5Q
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:25:19 -0500
Received: by mail-wm0-x244.google.com with SMTP id x63so5079225wmf.2
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 01:25:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510850407-17266-1-git-send-email-mst@redhat.com>
References: <1510850407-17266-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Nov 2017 09:24:57 +0000
Message-ID: <CAFEAcA8uoR98QD1p09q=XvmEy+0hSYYPZhRBCkh2z1mWtFuqVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] pc, pci, virtio: fixes for rc1
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

On 16 November 2017 at 16:40, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 6a7cb8c3d674815cab08d884740d203fded12249:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171115' into staging (2017-11-16 12:45:14 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 3831c07b89ab1f7aa1427bc56e9cdf70f5367933:
>
>   tests/bios-tables-test: Fix endianess problems when passing data to iasl (2017-11-16 18:36:54 +0200)
>
> ----------------------------------------------------------------
> pc, pci, virtio: fixes for rc1
>
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
