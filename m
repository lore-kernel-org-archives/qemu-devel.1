Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXMT7-0000dA-1u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXMT4-0001df-1X
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:58:53 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42305
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXMT3-0001ct-R0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:58:49 -0400
References: <150035832794.84.14057146505821937127@5d477a5b5989>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1f324fe7-d49a-58f8-8e1d-3c8376115551@cambridgegreys.com>
Date: Tue, 18 Jul 2017 07:58:42 +0100
MIME-Version: 1.0
In-Reply-To: <150035832794.84.14057146505821937127@5d477a5b5989>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Unified Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jasowang@redhat.com

Apologies, some bits of the second stage (sendmmsg) got in by mistake 
and broke the patch.

I will re-submit it later today including the proposed documentation, 
help and man page changes.

A.

On 18/07/17 07:12, no-reply@patchew.org wrote:
> Hi,
>
> This series failed build test on s390x host. Please find the details below.
>
> Type: series
> Message-id: 20170718060627.2107-1-anton.ivanov@cambridgegreys.com
> Subject: [Qemu-devel] [PATCH] Unified Socket Transport
>
[snip]


-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
