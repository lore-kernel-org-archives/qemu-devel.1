Received: from eggs.gnu.org ([2001:4830:134:3::10]:43616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNW0-0005kO-1r
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNVw-0003uw-W4
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:04:36 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:36223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNVw-0003ui-QB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:04:32 -0400
Received: by mail-pg0-x235.google.com with SMTP id u62so46600103pgb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:04:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
	<1497974944-27050-8-git-send-email-edgar.iglesias@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6c9ce148-c619-8f5e-11b8-cd9fbc212851@twiddle.net>
Date: Tue, 20 Jun 2017 11:04:29 -0700
MIME-Version: 1.0
In-Reply-To: <1497974944-27050-8-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/7] target-microblaze: Add CPU version
 10.0
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

On 06/20/2017 09:09 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@xilinx.com>
> 
> Add CPU version 10.0.
> 
> Signed-off-by: Edgar E. Iglesias<edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
