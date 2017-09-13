Received: from eggs.gnu.org ([2001:4830:134:3::10]:41055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds9w5-0000g0-Rw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds9w1-00039m-VE
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ds9w1-00037e-H5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:50:41 -0400
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-19-david@redhat.com>
	<20170913174933.5bc2f9ba.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <34bb9e7a-6f4b-0e87-d2ae-5e4305aff16e@redhat.com>
Date: Wed, 13 Sep 2017 17:50:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170913174933.5bc2f9ba.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 18/22] s390x: implement
 query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 13.09.2017 17:49, Cornelia Huck wrote:
> On Wed, 13 Sep 2017 15:24:13 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> CPU hotplug is only possible on a per core basis on s390x. So let's
>> add possible_cpus and properly wire everything up.
> 
> s/properly wire everything up/wire everything up properly/
> 
> ?
> 
> (fixing while... you get the idea)

:) Sure!

-- 

Thanks,

David
