Received: from eggs.gnu.org ([2001:4830:134:3::10]:42174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SyW-0000Cf-UI
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SyW-0004Nk-CM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:47:36 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:50369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0SyW-0004Nb-7r
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:47:36 -0400
Received: by mail-qt0-x234.google.com with SMTP id f15so31488636qtf.7
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:47:36 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f7decfa-3f3a-97a2-0041-00f2e00037c3@linaro.org>
Date: Fri, 6 Oct 2017 09:47:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-23-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/30] s390x/tcg: implement SIGP
 EMERGENCY SIGNAL
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

On 09/28/2017 04:37 PM, David Hildenbrand wrote:
> As preparation for TCG.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/sigp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
