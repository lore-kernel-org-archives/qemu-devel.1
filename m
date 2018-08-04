Received: from eggs.gnu.org ([2001:4830:134:3::10]:41368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fllEu-0007iH-W3
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 21:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fllEr-0000Vh-NA
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 21:20:16 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fllEr-0000T9-7o
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 21:20:13 -0400
Received: by mail-pl0-x243.google.com with SMTP id j8-v6so3254469pll.12
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 18:20:13 -0700 (PDT)
References: <20180802174042.29234-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <068aa8f9-bbd4-0ba1-d1ac-58b14156e536@linaro.org>
Date: Fri, 3 Aug 2018 18:20:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180802174042.29234-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/net/pcnet-pci: Convert away from
 old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, patches@linaro.org

On 08/02/2018 10:40 AM, Peter Maydell wrote:
> Peter Maydell (2):
>   hw/net/pcnet-pci: Convert away from old_mmio accessors
>   hw/net/pcnet-pci: Unify pcnet_ioport_read/write and
>     pcnet_mmio_read/write

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
