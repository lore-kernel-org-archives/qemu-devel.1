Received: from eggs.gnu.org ([2001:4830:134:3::10]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecVww-0001tc-8s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecVwv-0005YP-Jv
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:39:14 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:44962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecVwv-0005XQ-Ew
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:39:13 -0500
Received: by mail-ot0-x232.google.com with SMTP id t20so1264714ote.11
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 04:39:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 12:38:52 +0000
Message-ID: <CAFEAcA-0Vfu6-NXNTYnApcCsd7o24-FLKf=NWsnJY5nCLwAt6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/29] pc, pci, virtio: features, fixes,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 January 2018 at 20:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> changes since v3:
> - dropped vhost memory rework due to clang warnings
> - dropped vhost memslot rework due to merge conflicts
>
>
> The following changes since commit b4d6ed1c5ae519d3efb5297be3ef6625ca2a20f4:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-17' into staging (2018-01-18 15:25:17 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to f4bf56fb78ed0e9f60fa1ed656c14ff4c494da5a:
>
>   vhost: remove assertion to prevent crash (2018-01-18 21:52:39 +0200)
>
> ----------------------------------------------------------------
> pc, pci, virtio: features, fixes, cleanups
>
> A bunch of fixes, cleanus and new features all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied this version, thanks.

-- PMM
