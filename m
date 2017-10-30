Received: from eggs.gnu.org ([2001:4830:134:3::10]:37125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9AtH-0001fd-82
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9AtD-00042a-Bc
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:18:11 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:50311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9AtD-00041o-3g
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:18:07 -0400
Received: by mail-wm0-x22a.google.com with SMTP id s66so16102854wmf.5
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 07:18:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171030090320.93625-1-borntraeger@de.ibm.com>
References: <20171030090320.93625-1-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 14:17:45 +0000
Message-ID: <CAFEAcA8nzYfa2NVwvXaotSTS_X2Lz_RfGNuVjUwwBqH3fKyQOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] s390: fixups for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 30 October 2017 at 09:03, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Peter,
>
> The following changes since commit a93ece47fd9edbd4558db24300056c9a57d3bcd4:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20171026-tag' into staging (2017-10-27 14:43:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20171030
>
> for you to fetch changes up to 7a4ec18d117d74eedccdadca882331b928135465:
>
>   s390-*.img: update s390 bios with latest fixes (2017-10-30 09:04:25 +0100)
>
> ----------------------------------------------------------------
> s390x: fixups for 2.11
>
> - missing \r in the BIOS console output
> - CPU type name is now "s390x-cpu"
> - fixup for the host-model on z14 and older machine versions

Applied, thanks.

-- PMM
