Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKTdN-0004Km-VK
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKTdJ-0005hU-Ka
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:37:00 -0500
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-4-david@redhat.com>
	<228ec0b2-cd30-b33b-8120-bb28e3f83e66@redhat.com>
	<723f6454-8cac-08ed-bdb6-afddc4ed7ad1@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c6623c2e-415b-0951-cfa6-4d83a42b81d4@redhat.com>
Date: Wed, 7 Nov 2018 20:36:30 +0100
MIME-Version: 1.0
In-Reply-To: <723f6454-8cac-08ed-bdb6-afddc4ed7ad1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/4] s390x/zpci: move some
 hotplug checks to the pre_plug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

> 
> When did these function names drop the *_hot_plug postfix? Latest master does not reflect this change for me.
> Just figured I'd mention it now in case merging becomes a pain later ;)
> 

Mentioned it in the cover letter, part of another series
(also CC'ed to qemu-s390x@nongnu.org, so maybe easier to find for you).

>>
>>
> 
> The above concerns do not relate to any functionality of the code, so with them addressed, then:
> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 

Thanks!

-- 

Thanks,

David / dhildenb
