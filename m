Received: from eggs.gnu.org ([209.51.188.92]:57225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkhw-0005Yd-By
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkhv-00027r-NO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:08:20 -0500
References: <20190228122849.4296-1-david@redhat.com>
	<20190228171706.GC4925@habkost.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c36b0ab8-7c50-7e0b-262f-95f1304e8379@redhat.com>
Date: Fri, 1 Mar 2019 17:08:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190228171706.GC4925@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/3] qdev: Hotplug handler
 chaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>, Richard Henderson <rth@twiddle.net>, Eric Auger <eric.auger@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 28.02.19 18:17, Eduardo Habkost wrote:
> On Thu, Feb 28, 2019 at 01:28:46PM +0100, David Hildenbrand wrote:
>> Can somebody please pick this up in the near future? (@Eduardo, @MST,
>> @Paolo, @David - I have no idea who the right person is :) )
>>
>> The longer we wait, the more likely it is that some stuff gets upstreamed
>> that conflicts with patch 1 and will break unnoticed. (e.g. spapr PHB
>> hotplug was just upstreamed and required a fixup, luckily I was CC'ed on
>> that one).
> 
> I'm queueing it on machine-next, thanks!
> 

Thanks Eduardo! Have a great weekend!

-- 

Thanks,

David / dhildenb
