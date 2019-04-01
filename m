Received: from eggs.gnu.org ([209.51.188.92]:59552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hB3HM-00079O-GT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hB3HL-00086a-N0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:11:36 -0400
References: <20190328113458.8405-1-david@redhat.com>
	<20190401194857.681f65d6.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <980a5f10-3f82-1bb3-16e8-8382e2989af8@redhat.com>
Date: Mon, 1 Apr 2019 22:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190401194857.681f65d6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] s390x/kvm: Properly detect page
 size of initial memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


>> David Hildenbrand (2):
>>   s390x/kvm: Configure page size after memory has actually been
>>     initialized
> 
> I can queue that one to s390-next (not s390-fixes)... has this been tested?

I will resend both patches (once I find some spare time  ;) ). I will
also try to test, nly have to find a setup where I can use huge pages.


-- 

Thanks,

David / dhildenb
