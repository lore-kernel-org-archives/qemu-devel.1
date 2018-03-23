Received: from eggs.gnu.org ([2001:4830:134:3::10]:40485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezKmk-0003dK-Tj
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezKmj-000831-U6
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:23:02 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezKmj-00082U-Om
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:23:01 -0400
Received: by mail-ot0-x233.google.com with SMTP id r30-v6so12841066otr.2
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 04:23:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323091441.116971-1-borntraeger@de.ibm.com>
References: <20180323091441.116971-1-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 11:22:40 +0000
Message-ID: <CAFEAcA9Q-DKtH6UKH3R=er19jqxQRERGqLWogSL0YegdOTt6VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] s390x: Fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 23 March 2018 at 09:14, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Peter,
>
> 2 fixes for 2.12. Please pull
>
> The following changes since commit d522e0bd18364f6d784d43edab35b0563d21f6f3:
>
>   gitmodules: Use the QEMU mirror of qemu-palcode (2018-03-22 19:24:16 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20180323
>
> for you to fetch changes up to 06a97edac172f52971d7bdca6bb56a1edcb1b8f6:
>
>   s390x/cpumodel: fix feature groups and breakage of MSA8 (2018-03-23 09:05:42 +0000)
>
> ----------------------------------------------------------------
> s390x: Fixes for 2.12
>
> - Fix for the s390 cpumodel
> - Forbid multifunction PCI devices
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
