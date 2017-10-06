Received: from eggs.gnu.org ([2001:4830:134:3::10]:41069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SvW-0006K8-FB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SvV-0007sY-Oe
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:44:30 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:44530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0SvV-0007rw-JQ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:44:29 -0400
Received: by mail-qt0-x22b.google.com with SMTP id v28so22619811qtv.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:44:29 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98c44b77-ae67-9d19-a9a8-9758a30dcc4b@linaro.org>
Date: Fri, 6 Oct 2017 09:44:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/30] s390x/tcg: implement SIGP SENSE
 RUNNING STATUS
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
> Preparation for TCG, for KVM is this is completely handled in the
> kernel.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h  |  2 ++
>  target/s390x/sigp.c | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
