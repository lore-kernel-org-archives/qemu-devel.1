Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gG76g-0000Sf-60
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gG76c-0006wo-7E
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:45:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1gG76b-0006wC-Th
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:45:10 -0400
References: <20181025200944.12113-1-ppandit@redhat.com>
	<5b8a68c1-2787-af0d-959f-e0c9132f7004@oracle.com>
	<nycvar.YSQ.7.76.1810261452510.8270@xnncv>
	<deaad764-a684-2d17-043d-69fda37460f4@oracle.com>
	<nycvar.YSQ.7.76.1810270001580.7551@xnncv>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <893c5399-85c2-1eef-9733-2655e4ca6225@oracle.com>
Date: Fri, 26 Oct 2018 13:45:05 -0500
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810270001580.7551@xnncv>
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
To: P J P <ppandit@redhat.com>
Cc: Ameya More <ameya.more@oracle.com>, Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On 10/26/2018 1:37 PM, P J P wrote:
> +-- On Fri, 26 Oct 2018, Mark Kanda wrote --+
> | Deja vu requested that we include the following text in the commit message:
> |
> | 	Discovered by Deja vu Security. Reported by Oracle.
> |
> | Would that be acceptable?
> 
> Generally an email-id is used/preferred in the commit log message. We could
> use above for acknowledgement and avoid Reported-by in the commit log message
> if that suits Deja vu team.
> 
> Please let me know your/their preference.
> 

Yes, please use that acknowledgement text in lieu of a 'Reported-by' line.

Thanks,

-Mark
