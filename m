Received: from eggs.gnu.org ([2001:4830:134:3::10]:43195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSiUM-00061m-Qd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSiUM-0004gF-3p
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:33:30 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSiUL-0004fj-N1
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:33:30 -0400
Received: by mail-ot0-x242.google.com with SMTP id c15-v6so17972818otl.3
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 05:33:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611192206.339122-1-mst@redhat.com>
References: <20180611192206.339122-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 13:33:08 +0100
Message-ID: <CAFEAcA-04zXF2jKNwHVLEfp-+Bi7gf3iz-z5v_DsUrMgfsJFGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] pc: fixes
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

On 11 June 2018 at 20:23, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c74a:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-11' into staging (2018-06-11 15:31:20 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 11c39b5cd966ddc067a1ca0c5392ec9b666c45b7:
>
>   nvdimm: make persistence option symbolic (2018-06-11 22:19:57 +0300)
>
> ----------------------------------------------------------------
> pc: fixes
>
> A couple of fixes to acpi and nvdimm.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Ross Zwisler (2):
>       hw/i386: Update SSDT table used by "make check"
>       nvdimm: make persistence option symbolic
>

Applied, thanks.

-- PMM
