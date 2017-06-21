Received: from eggs.gnu.org ([2001:4830:134:3::10]:55507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNgBB-0004V1-Rp
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNgB7-0003vo-2N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:00:21 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:33497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNgB6-0003ve-V3
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:00:17 -0400
Received: by mail-qk0-x22e.google.com with SMTP id r62so83170117qkf.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:00:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498049955-28646-1-git-send-email-edgar.iglesias@gmail.com>
	<1498049955-28646-7-git-send-email-edgar.iglesias@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <338d3bf9-6977-5ec3-7d53-50cd19bec502@twiddle.net>
Date: Wed, 21 Jun 2017 07:00:12 -0700
MIME-Version: 1.0
In-Reply-To: <1498049955-28646-7-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target-microblaze: dec_barrel: Add
 BSIFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 06/21/2017 05:59 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@xilinx.com>
> 
> Add support for BSIFI.
> 
> Signed-off-by: Edgar E. Iglesias<edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
