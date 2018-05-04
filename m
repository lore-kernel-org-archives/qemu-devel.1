Received: from eggs.gnu.org ([2001:4830:134:3::10]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEZDh-0008P9-V8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEZDe-0003NI-Tv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:49:50 -0400
References: <20180503154936.18946-1-david@redhat.com>
	<20180504104907.2c0aebf4@redhat.com>
	<c7873a84-fa46-0a5d-1091-b2bb5688a1b6@redhat.com>
	<20180504120032.73ca4365@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c4fd861a-6418-c2ee-f6f7-64fb11688dce@redhat.com>
Date: Fri, 4 May 2018 13:49:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180504120032.73ca4365@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/8] MemoryDevice: introduce and use
 ResourceHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


>> Note how virtio-mem implements the MemoryDevice interface and how
>> resource assignments happens without any layer violations (and no
>> modifications to any hotplug handler).
> Thanks, that should be sufficient to get idea.
> I'll look into it and come back here with concrete comments or
> suggesting alternative.
> 

Thanks, looking forward to your reply. If there are any questions in the
meantime, please let me know!


-- 

Thanks,

David / dhildenb
