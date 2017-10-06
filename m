Received: from eggs.gnu.org ([2001:4830:134:3::10]:47617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TE2-0004IT-8s
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TDx-0001jE-N7
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:38 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:50562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0TDx-0001iu-I3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:33 -0400
Received: by mail-qt0-x231.google.com with SMTP id f15so31585089qtf.7
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:03:33 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c6a31ff-e207-75f3-8748-3a244ee7ce53@linaro.org>
Date: Fri, 6 Oct 2017 10:03:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-28-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 27/30] s390x/cpumodel: allow to enable
 SENSE RUNNING STATUS for qemu
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
> As we properly implement it, allow to enable it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
