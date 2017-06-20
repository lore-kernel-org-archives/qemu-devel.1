Received: from eggs.gnu.org ([2001:4830:134:3::10]:39298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNND7-0006k6-Jy
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNND3-0004G9-Mq
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:45:05 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNND3-0004Fr-Hh
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:45:01 -0400
Received: by mail-pg0-x22f.google.com with SMTP id u62so46378817pgb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:45:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
	<1497974944-27050-2-git-send-email-edgar.iglesias@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bd56a9a9-90ec-8d24-04e3-191079b23a5a@twiddle.net>
Date: Tue, 20 Jun 2017 10:44:58 -0700
MIME-Version: 1.0
In-Reply-To: <1497974944-27050-2-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/7] target-microblaze: dec_barrel: Use
 bool instead of unsigned int
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

On 06/20/2017 09:08 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@xilinx.com>
> 
> Use bool instead of unsigned int to represent flags.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias<edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
