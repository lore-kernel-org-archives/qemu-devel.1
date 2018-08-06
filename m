Received: from eggs.gnu.org ([2001:4830:134:3::10]:36046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmc7V-0006Fo-65
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 05:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmc7U-0005F0-FV
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 05:48:09 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmc7U-0005Em-8i
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 05:48:08 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so21073106oie.5
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 02:48:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803083830.775669-1-mst@redhat.com>
References: <20180803083830.775669-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 10:47:46 +0100
Message-ID: <CAFEAcA_Ri=u1PNW8kGBK+kH+nRX_A_SVRqBXMtunMZhNtRqrmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] pc, virtio: fixes
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

On 3 August 2018 at 10:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> Please consider for 3.0 if there is another rc.
>
> The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
>
>   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1c707d6990eaf3db0c9dc4557bba5458977e9f8d:
>
>   tests/acpi: update tables after memory hotplug changes (2018-08-03 11:35:21 +0300)
>
> ----------------------------------------------------------------
> pc, virtio: fixes
>
> A couple of last minute fixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Thanks for clarifying the status of the various bugfixes and
preparing the alternate pullreq. After thinking it over, I've
decided to apply this set.

-- PMM
