Received: from eggs.gnu.org ([2001:4830:134:3::10]:60224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgAjS-00022E-1i
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgAjP-0007i7-ER
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dgAjP-0007i2-8k
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:16:07 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
	<f5080f25-54d9-0a63-db7d-507d64b3d7a1@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4c11bb1e-c25f-ed00-651b-e9f9780215d1@redhat.com>
Date: Fri, 11 Aug 2017 16:16:01 +0200
MIME-Version: 1.0
In-Reply-To: <f5080f25-54d9-0a63-db7d-507d64b3d7a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
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


> By the way, all the other targets that have KVM have a separate header
> for things like this: kvm_arm.h, kvm_ppc.h, kvm_mips.h, kvm_i386.h
> ... maybe it's time for kvm_s390x.h now?

Definitely!

> 
>  Thomas
> 


-- 

Thanks,

David
