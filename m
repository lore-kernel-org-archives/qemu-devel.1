Received: from eggs.gnu.org ([2001:4830:134:3::10]:52186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVhV1-0004YC-IE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVhUy-0004pY-Gd
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVhUy-0004ot-AF
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AE6B4DD4B
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:01:55 +0000 (UTC)
References: <149996191269.69.6935745034515082236@5d477a5b5989>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a210b1b5-e983-41b8-35ec-4a9e2a3f5b3a@redhat.com>
Date: Thu, 13 Jul 2017 19:01:50 +0200
MIME-Version: 1.0
In-Reply-To: <149996191269.69.6935745034515082236@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/41] Misc patches for QEMU 2.10 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

On 13/07/2017 18:05, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 

False positive due to non-camelcase type in hw/dma/rc4030.c.

> Checking PATCH 29/41: memory/iommu: QOM'fy IOMMU MemoryRegion...
> ERROR: spaces required around that '*' (ctx:WxO)
> #133: FILE: hw/dma/rc4030.c:720:
> +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
Thanks,

Paolo
