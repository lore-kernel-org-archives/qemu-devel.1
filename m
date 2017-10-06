Received: from eggs.gnu.org ([2001:4830:134:3::10]:41911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sxl-00081q-Nw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sxl-0003Et-0v
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:46:49 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:54018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Sxk-0003EW-SN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:46:48 -0400
Received: by mail-qt0-x230.google.com with SMTP id n61so3493471qte.10
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:46:48 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-22-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ee7433e-c628-3d4e-b87b-000edcda7b1a@linaro.org>
Date: Fri, 6 Oct 2017 09:46:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-22-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/30] s390x/tcg: implement SIGP
 EXTERNAL CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/28/2017 04:36 PM, David Hildenbrand wrote:
> As preparation for TCG.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/sigp.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
