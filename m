Received: from eggs.gnu.org ([2001:4830:134:3::10]:50641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGSyM-0005CV-PG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGSyM-0004j1-2J
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:29:18 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGSyL-0004ih-R7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:29:17 -0400
Received: by mail-wm0-x22e.google.com with SMTP id d127so67085932wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 09:29:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170529173751.3443-1-drjones@redhat.com>
References: <20170529173751.3443-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 17:28:56 +0100
Message-ID: <CAFEAcA-fEFnLuKsAxqbCeRFXf_EtQWLT+UfyBBYF2UsOLM4xhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/arm/virt: numa: provide distance
 info when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 29 May 2017 at 18:37, Andrew Jones <drjones@redhat.com> wrote:
> Andrew Jones (2):
>   hw/arm/virt-acpi-build: build SLIT when needed
>   hw/arm/virt: fdt: generate distance-map when needed
>
>  hw/arm/virt-acpi-build.c |  4 ++++
>  hw/arm/virt.c            | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)



Applied to target-arm.next, thanks.

-- PMM
