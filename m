Received: from eggs.gnu.org ([2001:4830:134:3::10]:40760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgCXR-0003ND-GA
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgCXN-0002Uo-FU
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:11:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dgCXN-0002UQ-9G
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:11:49 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-5-david@redhat.com>
	<f5d6b3dc-3b05-e93a-8b6f-60c9fd922efb@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3e0cb875-7f8d-34cd-105a-c4ced00d3b1f@redhat.com>
Date: Fri, 11 Aug 2017 18:11:45 +0200
MIME-Version: 1.0
In-Reply-To: <f5d6b3dc-3b05-e93a-8b6f-60c9fd922efb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 4/5] target/s390x: remove all
 CONFIG_KVM from cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 16:19, Thomas Huth wrote:
> On 11.08.2017 09:46, David Hildenbrand wrote:
>> Let's move everything into internal.h
> 
> Or kvm_s390x.h ? ;-)

And even kvm-stubs.c!

> 
>  Thomas
> 
> 


-- 

Thanks,

David
