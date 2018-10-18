Received: from eggs.gnu.org ([2001:4830:134:3::10]:35349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9J9-0004Zx-ED
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9J8-0005Gv-KS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:29:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD9J8-0005Dr-5C
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:29:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id s69-v6so24130356oie.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:29:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018142743.29489-1-eric.auger@redhat.com>
References: <20181018142743.29489-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 15:29:28 +0100
Message-ID: <CAFEAcA-dy=OdwwzjHcLjSACaZnPb=PzTK-fUvzL5R=iMxMhqjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: introduce fdt_add_memory_node
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>

On 18 October 2018 at 15:27, Eric Auger <eric.auger@redhat.com> wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>
> We introduce an helper to create a memory node.

Hi; this seems to be missing the rationale for doing this ?

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

thanks
-- PMM
