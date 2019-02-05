Received: from eggs.gnu.org ([209.51.188.92]:48607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4gi-0004S6-MN
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4gh-0007jM-Vo
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:39:12 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:36193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4gh-0007iH-Pn
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:39:11 -0500
Received: by mail-ot1-x331.google.com with SMTP id k98so7155077otk.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
	<CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
	<20190205110518-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190205110518-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 17:38:59 +0000
Message-ID: <CAFEAcA8-ovqcRvFqRxr0jyqaTebDE5iZ9_C3=cm66RQ3PKRZzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
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

On Tue, 5 Feb 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> OK I reverted the whole part dealing with vhost-user and reposted.
>
> I'm sure it's fine now.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
