Received: from eggs.gnu.org ([2001:4830:134:3::10]:45635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gG2gW-0008Th-Hw
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gG2gQ-0001nS-Iv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:01:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1gG2gQ-0001lT-6J
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:01:50 -0400
References: <20181025200944.12113-1-ppandit@redhat.com>
	<5b8a68c1-2787-af0d-959f-e0c9132f7004@oracle.com>
	<nycvar.YSQ.7.76.1810261452510.8270@xnncv>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <deaad764-a684-2d17-043d-69fda37460f4@oracle.com>
Date: Fri, 26 Oct 2018 09:01:41 -0500
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810261452510.8270@xnncv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check message length value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Ameya More <ameya.more@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>



On 10/26/2018 4:25 AM, P J P wrote:
> +-- On Thu, 25 Oct 2018, Ameya More wrote --+
> | While Mark and I reported this issue to you, it was actually discovered by
> | Dejvau Security and they should receive credit for reporting this issue.
> | http://www.dejavusecurity.com
> 
> I see; Would it be possible to share email-id of the original reporter to
> include in the commit log message?

Deja vu requested that we include the following text in the commit message:

	Discovered by Deja vu Security. Reported by Oracle.

Would that be acceptable?

Thanks,

-Mark
