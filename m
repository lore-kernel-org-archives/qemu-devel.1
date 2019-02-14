Received: from eggs.gnu.org ([209.51.188.92]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKE0-00040n-JF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKDy-0006zJ-K0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:51:00 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guKDy-0006fO-6R
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:50:58 -0500
Received: by mail-ot1-x342.google.com with SMTP id u16so11581097otk.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-5-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 16:50:36 +0000
Message-ID: <CAFEAcA8RYbew8Om4nUG2Y3JyMtmmmM1oj0_iOOtSSp6yP8nLQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 04/18] hw/arm/virt: Rename highmem IO
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>
> In preparation for a split of the memory map into a static
> part and a dynamic part floating after the RAM, let's rename the
> regions located after the RAM
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
