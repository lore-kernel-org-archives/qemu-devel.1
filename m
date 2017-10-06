Received: from eggs.gnu.org ([2001:4830:134:3::10]:40136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Ss1-0004ZH-Iw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Ss0-0003FB-Va
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:40:53 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:51956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Ss0-0003F2-Qv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:40:52 -0400
Received: by mail-qt0-x22b.google.com with SMTP id q4so31436316qtq.8
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:40:52 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e0360e2-6f8d-86e7-9629-bbe1b2568421@linaro.org>
Date: Fri, 6 Oct 2017 09:40:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/30] MAINTAINERS: use s390 KVM
 maintainers for target/s390x/sigp.c
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
> All code in target/s390x/sigp.c was factored out from
> target/s390x/kvm.c, so let's also copy the entry in the MAINTAINERS
> file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Probably should squash with previous, but...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
