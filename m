Received: from eggs.gnu.org ([209.51.188.92]:50036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1XsX-0001sq-6y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1XsV-0005GW-TH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:50:41 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1XsV-00054F-Nv
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:50:39 -0500
Received: by mail-oi1-x242.google.com with SMTP id j10so10012767oij.13
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 06:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20190306110711.309-1-laurent@vivier.eu>
In-Reply-To: <20190306110711.309-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Mar 2019 14:50:12 +0000
Message-ID: <CAFEAcA9pjHpqtBCXZGDXEnzW8=FvnGER_MZkNC0NxZX6ORtwzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x <qemu-s390x@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zhang Chen <zhangckid@gmail.com>, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, 6 Mar 2019 at 11:09, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit a3e3b0a7bd5de211a62cdf2d6c12b96d3c403560:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-03-05' into staging (2019-03-05 19:23:45 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 0e081fde8a3d80383adf2e802fc0c03af44c5436:
>
>   thunk: fix of malloc to g_new (2019-03-06 11:27:32 +0100)
>
> ----------------------------------------------------------------
> trivial patches pull request (20190206)
>
> - acpi: remove unused functions/variables
> - tests: remove useless architecture checks
> - some typo fixes and documentation update
> - flash_cfi02: fix memory leak
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
